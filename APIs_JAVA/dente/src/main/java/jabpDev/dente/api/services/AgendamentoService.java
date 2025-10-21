package jabpDev.dente.api.services;


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
                .empresaId(empresa.get().getId())
                .pacienteId(paciente.get().getId())
                .dentistaId(dentista.get().getId())
                .servicoId(servico.get().getId())
                .dataHora(body.dataHora())
                .observacoes(body.observacoes())
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
}
