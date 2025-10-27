package jabpDev.dente.api.services;


import jabpDev.dente.api.dto.request.BuscaAgendamentosDtoRequest;
import jabpDev.dente.api.dto.request.NovoAgendamentoDtoRequest;
import jabpDev.dente.api.dto.response.*;
import jabpDev.dente.api.dto.response.sub_response.DentistasDtoResponse;
import jabpDev.dente.api.dto.response.sub_response.ServicosDtoResponse;
import jabpDev.dente.api.entitys.*;
import jabpDev.dente.api.exceptions.ErrorException;
import jabpDev.dente.api.repositories.*;
import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Objects;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
public class AgendamentoService {

    private final EmpresaRepository empresaRepository;
    private final DentistaRepository dentistaRepository;
    private final ServicosRepository servicosRepository;
    private final PacienteRepository pacienteRepository;
    private final AgendamentoRepository agendamentoRepository;
    private final ServicesGerais servicesGerais;


    public ServicosDentistasDtoResponse buscaDentistasESevicos(){

        String nmEmpresa =  SecurityContextHolder.getContext().getAuthentication().getName();
        Optional<Empresa> empresa = empresaRepository.findByEmailClinica(nmEmpresa);
        if (empresa.isEmpty()){
            throw new ErrorException("Sem permissão para cadastrar dentista.\nRealizar login novamente");
        }

        List<BuscaDentistasDtoResponse> dentistas = dentistaRepository.findByEmpresaId(empresa.get().getId());
        List<BuscarServicosDtoResponse> servicos = servicosRepository.findByEmpresaId(empresa.get().getId());


        List<DentistasDtoResponse> dtoResponses = dentistas.stream()
                .map(d -> {
                    return new DentistasDtoResponse(
                            d.id(),
                            d.nome()
                    );
                }).collect(Collectors.toList());

        List<ServicosDtoResponse> servicosDtoResponses = servicos.stream()
                .map(s -> {
                    return new ServicosDtoResponse(
                            s.id(),
                            s.nome()
                    );
                }).collect(Collectors.toList());

        return new ServicosDentistasDtoResponse(servicosDtoResponses, dtoResponses);
    }


    @Transactional
    public void criaNovoAgendamento(NovoAgendamentoDtoRequest body) {
        String nmEmpresa =  SecurityContextHolder.getContext().getAuthentication().getName();
        Optional<Empresa> empresa = empresaRepository.findByEmailClinica(nmEmpresa);
        if (empresa.isEmpty()){
            throw new ErrorException("Sem permissão para cadastrar dentista.\nRealizar login novamente");
        }

        Optional<Dentista> dentista = dentistaRepository.findByIdAndEmpresaId(body.dentistaId(), empresa.get().getId());
        if (dentista.isEmpty()){
            throw new ErrorException("Dentista não encontrado para a clinica.");
        }

        Optional<Paciente> paciente = pacienteRepository.findByCpfAndEmpresaId(body.cpfPaciente(), empresa.get().getId());
        if (paciente.isEmpty()){
            throw new ErrorException("Paciente não encontrado para a clinica.");
        }

        Optional<Servicos> servico = servicosRepository.findByIdAndEmpresaId(body.servicoId(), empresa.get().getId());
        if (servico.isEmpty()){
            throw new ErrorException("Serviço não encontrado para a clinica.");
        }

        Agendamento agendamento = Agendamento.builder()
                .empresa(empresa.get())
                .paciente(paciente.get())
                .servico(servico.get())
                .dentista(dentista.get())
                .dataHora(body.dataHora())
                .observacoes(body.observacoes())
                .status("Pendente")
                .build();

        Agendamento response =  agendamentoRepository.save(agendamento);
        if (response.getId() > 0){
            servicesGerais.enviarEmailConfirmacaoAgendamento(
                    paciente.get(),
                    dentista.get(),
                    response,
                    empresa.get().getEmailClinica()
            );
            return;
        } else {
            throw new ErrorException("Erro ao criar agendamento.");
        }
    }


    public List<BuscaAgendamentosDtoResponse> buscaAgendamentos() {
        String nmEmpresa =  SecurityContextHolder.getContext().getAuthentication().getName();
        Optional<Empresa> empresa = empresaRepository.findByEmailClinica(nmEmpresa);
        if (empresa.isEmpty()){
            throw new ErrorException("Sem permissão para cadastrar dentista.\nRealizar login novamente");
        }
        List<AgendamentosDtoResponse> agendamentos = agendamentoRepository.findByEmpresaId(empresa.get().getId());
        List<BuscaAgendamentosDtoResponse> response = agendamentos.stream()
                .map(a -> {
                    LocalDate localDate = LocalDate.parse(
                            a.dataHora().substring(0, 10),
                            DateTimeFormatter.ofPattern("dd/MM/yyyy")
                    );
                    return new BuscaAgendamentosDtoResponse(
                            localDate,
                            a.id()
                    );

                }).collect(Collectors.toList());
        return response;
    }


    public List<AgendamentoPorPacienteResponse> buscaAgendamentosPorDadosPaciente(List<BuscaAgendamentosDtoRequest> body) {

        String nmEmpresa =  SecurityContextHolder.getContext().getAuthentication().getName();
        Optional<Empresa> empresa = empresaRepository.findByEmailClinica(nmEmpresa);
        if (empresa.isEmpty()){
            throw new ErrorException("Sem permissão para cadastrar dentista.\nRealizar login novamente");
        }
        List<Long> idsAgendamentos = body.stream()
                .map(BuscaAgendamentosDtoRequest::id)
                .collect(Collectors.toList());

        // Usa a data do primeiro item (assumindo todas do mesmo dia)
        String dataIso = body.get(0).data(); // "2025-10-23"

        // Converte para "dd/MM/yyyy"
        LocalDate data = LocalDate.parse(dataIso, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        String dataFormatada = data.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));

        List<AgendamentoPorPacienteResponse> agendamentos = agendamentoRepository.findByEmpresaIdAndDataAndIds(
                empresa.get().getId(),
                idsAgendamentos,
                dataFormatada
        );

        List<AgendamentoPorPacienteResponse> response = agendamentos.stream()
                .map(a -> {
                    return new AgendamentoPorPacienteResponse(
                            a.agendamentoId(),
                            a.status(),
                            a.pacienteNome(),
                            a.servico(),
                            a.datahorario(),
                            a.observacoes(),
                            a.pacienteId()
                    );
                }).collect(Collectors.toList());
        return response;
    }

    public void marcaAgendamentoComoRealizado(Long agendamentoId){
        String nmEmpresa =  SecurityContextHolder.getContext().getAuthentication().getName();
        Optional<Empresa> empresa = empresaRepository.findByEmailClinica(nmEmpresa);
        if (empresa.isEmpty()){
            throw new ErrorException("Sem permissão para cadastrar dentista.\nRealizar login novamente");
        }

        Optional<Agendamento> agendamento = agendamentoRepository.findByIdAndEmpresaId(agendamentoId, empresa.get().getId());
        if (agendamento.isPresent()){
            Agendamento agendamentoNew = agendamento.get();
            agendamentoNew.setStatus("Realizado");
            Agendamento agendamentoSet = agendamentoRepository.save(agendamentoNew);
            if (!Objects.equals(agendamentoSet.getStatus(), "Realizado")){
                throw new ErrorException("Erro ao marcar agendamento como realizado, tentar novamento");
            }
        }
    }

    public void marcaAgendamentoComoCancelado(Long agendamentoId){
        String nmEmpresa =  SecurityContextHolder.getContext().getAuthentication().getName();
        Optional<Empresa> empresa = empresaRepository.findByEmailClinica(nmEmpresa);
        if (empresa.isEmpty()){
            throw new ErrorException("Sem permissão para cadastrar dentista.\nRealizar login novamente");
        }

        Optional<Agendamento> agendamento = agendamentoRepository.findByIdAndEmpresaId(agendamentoId, empresa.get().getId());
        if (agendamento.isPresent()){
            Agendamento agendamentoNew = agendamento.get();
            agendamentoNew.setStatus("Cancelado");
            Agendamento agendamentoSet = agendamentoRepository.save(agendamentoNew);
            if (!Objects.equals(agendamentoSet.getStatus(), "Cancelado")){
                throw new ErrorException("Erro ao cancelar agenadamento, tentar novamento");
            }
        }
    }


    public List<HistoricoAgendamentosResponse> buscaHistoricoAgendamentos(Long pacienteId){
        String nmEmpresa =  SecurityContextHolder.getContext().getAuthentication().getName();
        Optional<Empresa> empresa = empresaRepository.findByEmailClinica(nmEmpresa);
        if (empresa.isEmpty()){
            throw new ErrorException("Sem permissão para cadastrar dentista.\nRealizar login novamente");
        }

        List<HistoricoAgendamentosResponse> agendamento = agendamentoRepository.findByPacienteIdAndEmpresaId(pacienteId, empresa.get().getId());
//        List<HistoricoAgendamentosResponse> response = agendamento.stream()
//                .map(c -> {
//                    return new HistoricoAgendamentosResponse(
//                            c.dataHora(),
//                            c.nomePaciente(),
//                            c.status(),
//                            c.servico(),
//                            c.atendimento()
//
//                    );
//                }).collect(Collectors.toList());
        return agendamento;
    }
}
