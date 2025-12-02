package jabpDev.dente.api.services;


import jabpDev.dente.api.dto.request.RegistrarPagamentoRequest;
import jabpDev.dente.api.dto.response.ListarConveniosResponse;
import jabpDev.dente.api.entitys.*;
import jabpDev.dente.api.exceptions.ErrorException;
import jabpDev.dente.api.repositories.*;
import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
public class PagamentoService {

    private final EmpresaRepository empresaRepository;
    private final PagamentoRepository pagamentoRepository;
    private final ConvenioRepository convenioRepository;
    private final AgendamentoRepository agendamentoRepository;
    private final DentistaRepository dentistaRepository;

    public List<ListarConveniosResponse> buscaConveniosPagamento(){
        String nmEmpresa =  SecurityContextHolder.getContext().getAuthentication().getName();
        Optional<Empresa> empresa = empresaRepository.findByEmailClinica(nmEmpresa);
        if (empresa.isEmpty()){
            throw new ErrorException("Realizar login novamente");
        }

        List<Convenio> convenios = convenioRepository.findByEmpresaId(empresa.get().getId());
        return convenios.stream()
                .map(c -> {
                    return new ListarConveniosResponse(
                            c.getId(),
                            c.getParceiro()
                    );
                }).collect(Collectors.toList());
    }

    @Transactional
    public void registrarPagamento(RegistrarPagamentoRequest body){
        if (body.agendamentoId() == 0 ){
            throw new ErrorException("Agendamento não informado");
        }
        String nmEmpresa =  SecurityContextHolder.getContext().getAuthentication().getName();
        Optional<Empresa> empresa = empresaRepository.findByEmailClinica(nmEmpresa);
        if (empresa.isEmpty()){
            throw new ErrorException("Realizar login novamente");
        }

        Optional<Agendamento> agendamento = agendamentoRepository.findByEmpresaIdAndId(empresa.get().getId(), body.agendamentoId());
        if (!agendamento.isPresent()){
            throw new ErrorException("Agendamento não encontrado");
        }


        Optional<Convenio> convenio = convenioRepository.findByIdAndEmpresaId(body.convenioId(), empresa.get().getId());

        Optional<Dentista>  dentista = dentistaRepository.findByIdAndEmpresaId(agendamento.get().getDentista().getId(), empresa.get().getId());

        Optional<Pagamento> pagamentoXagendamento = pagamentoRepository.findByAgendamentoId(agendamento.get().getId());
        if (pagamentoXagendamento.isPresent()){
            throw new ErrorException("Pagamento já realizado");
        }else {
            Pagamento pagamento = Pagamento.builder()
                    .agendamento(agendamento.get())
                    .status(body.status())
                    .data_pagamento(LocalDate.now())
                    .tipo_pagamento(body.tipoPagamento())
                    .convenio(convenio.get())
                    .dentista(dentista.get())
                    .empresa(empresa.get())
                    .percento_dentista(body.percentoDentista())
                    .valor_atual(body.valorAtual())
                    .valor_cobrado(body.valorCobrado())
                    .valor_desconto(body.valorDesconto())
                    .valor_recebido(body.valorLiquido())
                    .tratamento_fechado(body.tratamentoFechado())
                    .build();
            Pagamento response = pagamentoRepository.save(pagamento);
            if (response.getId() <= 0) {
                throw new ErrorException("Não foi possivel registrar o pagamento");
            }
        }
    }
}
