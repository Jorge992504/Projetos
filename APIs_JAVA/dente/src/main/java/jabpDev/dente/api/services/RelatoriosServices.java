package jabpDev.dente.api.services;


import jabpDev.dente.api.dto.request.AddNovoRelatorioRequest;
import jabpDev.dente.api.dto.response.AgendamentosDtoResponse;
import jabpDev.dente.api.dto.response.ListaRelatoriosDtoResponse;
import jabpDev.dente.api.dto.response.RelatorioClinicoProcedimentosResponse;
import jabpDev.dente.api.entitys.Agendamento;
import jabpDev.dente.api.entitys.Empresa;
import jabpDev.dente.api.entitys.Relatorio;
import jabpDev.dente.api.entitys.Servicos;
import jabpDev.dente.api.exceptions.ErrorException;
import jabpDev.dente.api.repositories.AgendamentoRepository;
import jabpDev.dente.api.repositories.EmpresaRepository;
import jabpDev.dente.api.repositories.RelatoriosRepository;
import jabpDev.dente.api.repositories.ServicosRepository;
import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
public class RelatoriosServices {

    private final EmpresaRepository empresaRepository;
    private final RelatoriosRepository relatoriosRepository;
    private final ServicosRepository servicosRepository;
    private final AgendamentoRepository agendamentoRepository;

    @Transactional
    public ResponseEntity<?> addNovoRelatorio(AddNovoRelatorioRequest relatorios){

        String nmEmpresa =  SecurityContextHolder.getContext().getAuthentication().getName();
        Optional<Empresa> empresa = empresaRepository.findByEmailClinica(nmEmpresa);
        if (empresa.isEmpty()){
            throw new ErrorException("Sem permissão para cadastrar dentista.\nRealizar login novamente");
        }
        List<Relatorio> lista = relatorios
                .nmRelatorio()
                .stream()
                .map(nome -> Relatorio.builder()
                        .descricao(nome)  // agora salva um por vez
                        .empresaId(relatorios.especifico() ? empresa.get().getId() : 0)
                        .build()
                ).toList();

        List<Relatorio> response = relatoriosRepository.saveAll(lista);

        if (!response.isEmpty()) {
            return ResponseEntity.status(200).build();
        } else {
            throw new ErrorException("Erro ao adicionar os tipos de relatorio");
        }
    }


    public List<ListaRelatoriosDtoResponse> buscaTiposRelatorios (){
        String nmEmpresa =  SecurityContextHolder.getContext().getAuthentication().getName();
        Optional<Empresa> empresa = empresaRepository.findByEmailClinica(nmEmpresa);
        if (empresa.isEmpty()){
            throw new ErrorException("Sem permissão para cadastrar dentista.\nRealizar login novamente");
        }
        return relatoriosRepository.findByEmpresaId(empresa.get()
                .getId());
    }

    public List<RelatorioClinicoProcedimentosResponse>  buscaProcedimentosMaisRealizados(String filtro){
        String nmEmpresa =  SecurityContextHolder.getContext().getAuthentication().getName();
        Optional<Empresa> empresa = empresaRepository.findByEmailClinica(nmEmpresa);
        if (empresa.isEmpty()){
            throw new ErrorException("Sem permissão para cadastrar dentista.\nRealizar login novamente");
        }

        List<Agendamento> lista;

        if (filtro.equalsIgnoreCase("realizados")) {

            lista = agendamentoRepository.findByEmpresaIdAndStatus(empresa.get().getId());
        } else {
            lista = agendamentoRepository.findTodosByEmpresa(empresa.get().getId());
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
}
