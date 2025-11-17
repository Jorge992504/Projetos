package jabpDev.dente.api.services;


import jabpDev.dente.api.dto.response.AgendamentoCabecaResponse;
import jabpDev.dente.api.dto.response.RelatorioAgendamentoResponse;
import jabpDev.dente.api.dto.response.RelatorioClinicoProcedimentosResponse;
import jabpDev.dente.api.entitys.Agendamento;
import jabpDev.dente.api.entitys.Empresa;
import jabpDev.dente.api.exceptions.ErrorException;
import jabpDev.dente.api.repositories.AgendamentoRepository;
import jabpDev.dente.api.repositories.EmpresaRepository;
import jabpDev.dente.api.repositories.RelatoriosRepository;
import jabpDev.dente.api.repositories.ServicosRepository;
import lombok.AllArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
public class RelatoriosServices {

    private final EmpresaRepository empresaRepository;
    private final RelatoriosRepository relatoriosRepository;
    private final ServicosRepository servicosRepository;
    private final AgendamentoRepository agendamentoRepository;



    public List<RelatorioClinicoProcedimentosResponse>  buscaProcedimentosMaisRealizados(String filtro){
        String nmEmpresa =  SecurityContextHolder.getContext().getAuthentication().getName();
        Optional<Empresa> empresa = empresaRepository.findByEmailClinica(nmEmpresa);
        if (empresa.isEmpty()){
            throw new ErrorException("Sem permissão.\nRealizar login novamente");
        }

        List<Agendamento> lista;

        if (filtro.equalsIgnoreCase("realizados")) {

            lista = agendamentoRepository.findByEmpresaIdAndStatus(empresa.get().getId());
        } else {
            lista = agendamentoRepository.findAllByEmpresa(empresa.get().getId());
        }

        if (lista.isEmpty()) {
            return List.of();
        }

        long total = lista.size();
        Map<String, Long> agrupado = lista.stream()
                .collect(Collectors.groupingBy(
                        a -> a.getServico().getNome(),
                        Collectors.counting()
                ));

        // MONTA O RETORNO
        return agrupado.entrySet().stream()
                .map(e -> {
                    String servico = e.getKey();
                    Long quantidade = e.getValue();
                    Double percentual = (quantidade * 100.0) / total;

                    return new RelatorioClinicoProcedimentosResponse(
                            servico,
                            quantidade,
                            Math.round(percentual * 100.0) / 100.0 // 2 casas
                    );
                })
                .sorted(Comparator.comparing(RelatorioClinicoProcedimentosResponse::quantidade).reversed()) // mais realizados primeiro
                .toList();

    }

    public List<AgendamentoCabecaResponse> buscaRelatoriosAgendamentos(String filtro) {

        String nmEmpresa = SecurityContextHolder.getContext().getAuthentication().getName();
        Optional<Empresa> empresa = empresaRepository.findByEmailClinica(nmEmpresa);

        if (empresa.isEmpty()){
            throw new ErrorException("Sem permissão.\nRealizar login novamente");
        }

        List<Agendamento> lista = agendamentoRepository.buscaTodos(empresa.get().getId());
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy - HH:mm");

        List<AgendamentoCabecaResponse> resultado = new ArrayList<>();

        // ---------- SEMANA ----------
        if (filtro.equalsIgnoreCase("semana")) {

            lista.stream()
                    .collect(Collectors.groupingBy(a -> {
                        LocalDateTime dt = LocalDateTime.parse(a.getDataHora(), formatter);
                        return dt.with(DayOfWeek.MONDAY).toLocalDate(); // início da semana
                    }, LinkedHashMap::new, Collectors.toList()))
                    .forEach((inicioSemana, ags) -> {

                        AgendamentoCabecaResponse resp = montarGrupoSemana(ags, inicioSemana);
                        resultado.add(resp);

                    });

        }
        // ---------- MÊS ----------
        else if (filtro.equalsIgnoreCase("mes")) {

            lista.stream()
                    .collect(Collectors.groupingBy(a -> {
                        LocalDateTime dt = LocalDateTime.parse(a.getDataHora(), formatter);
                        return YearMonth.from(dt);
                    }, LinkedHashMap::new, Collectors.toList()))
                    .forEach((mes, ags) -> {

                        AgendamentoCabecaResponse resp = montarGrupoMes(ags, mes);
                        resultado.add(resp);

                    });

        } else {
            throw new ErrorException("Filtro inválido. Use 'semana' ou 'mes'.");
        }

        return resultado;
    }



    private LocalDateTime parseData(String dataHora, DateTimeFormatter formatter) {
        try {
            return LocalDateTime.parse(dataHora, formatter);
        } catch (Exception e) {
            throw new ErrorException("Erro ao interpretar data: " + dataHora);
        }
    }

    private AgendamentoCabecaResponse montarGrupoSemana(List<Agendamento> ags, LocalDate inicioSemana) {

        LocalDate fimSemana = inicioSemana.plusDays(6);

        return montarGrupo(
                ags,
                "semana",
                inicioSemana.format(DateTimeFormatter.ofPattern("dd/MM/yyyy")),
                fimSemana.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"))
        );
    }

    private AgendamentoCabecaResponse montarGrupoMes(List<Agendamento> ags, YearMonth mes) {

        String inicio = "01/" + mes.format(DateTimeFormatter.ofPattern("MM/yyyy"));
        String fim = mes.atEndOfMonth().format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));

        return montarGrupo(
                ags,
                "mes",
                inicio,
                fim
        );
    }

    private AgendamentoCabecaResponse montarGrupo(
            List<Agendamento> ags,
            String tipo,
            String inicio,
            String fim
    ) {

        long total = ags.size();
        long realizados = ags.stream().filter(a -> a.getStatus().equalsIgnoreCase("Realizado")).count();
        long pendentes = ags.stream().filter(a -> a.getStatus().equalsIgnoreCase("Pendente")).count();
        long cancelados = ags.stream().filter(a -> a.getStatus().equalsIgnoreCase("Cancelado")).count();

        List<RelatorioAgendamentoResponse> itens = ags.stream().map(a -> {

            String[] partes = a.getDataHora().split(" - ");
            String data = partes[0];
            String hora = partes.length > 1 ? partes[1] : "";

            return new RelatorioAgendamentoResponse(
                    a.getServico().getNome(),
                    data,
                    hora,
                    a.getStatus()
            );

        }).toList();

        return new AgendamentoCabecaResponse(
                tipo,
                inicio,
                fim,
                total,
                realizados,
                pendentes,
                cancelados,
                itens
        );
    }
}
