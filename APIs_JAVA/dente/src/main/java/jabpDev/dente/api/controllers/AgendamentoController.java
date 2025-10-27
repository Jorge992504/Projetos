package jabpDev.dente.api.controllers;


import jabpDev.dente.api.dto.request.BuscaAgendamentosDtoRequest;
import jabpDev.dente.api.dto.request.NovoAgendamentoDtoRequest;
import jabpDev.dente.api.dto.response.AgendamentoPorPacienteResponse;
import jabpDev.dente.api.dto.response.BuscaAgendamentosDtoResponse;
import jabpDev.dente.api.dto.response.HistoricoAgendamentosResponse;
import jabpDev.dente.api.dto.response.ServicosDentistasDtoResponse;
import jabpDev.dente.api.services.AgendamentoService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@AllArgsConstructor

@RequestMapping("/agendamentos")
public class AgendamentoController {

    private final AgendamentoService agendamentoService;

    @GetMapping("/busca/dentistas-servicos")
    public ServicosDentistasDtoResponse buscaDentistasESevicos(){
        return agendamentoService.buscaDentistasESevicos();
    }

    @PostMapping("/novo")
    public void criaNovoAgendamento(@RequestBody NovoAgendamentoDtoRequest body) {
        agendamentoService.criaNovoAgendamento(body);
    }

    @GetMapping("/busca/todos")
    public List<BuscaAgendamentosDtoResponse> buscaAgendamentos() {
        return agendamentoService.buscaAgendamentos();
    }

    @PostMapping("/busca/dados-paciente")
    public List<AgendamentoPorPacienteResponse> buscaAgendamentosPorDadosPaciente(@RequestBody List<BuscaAgendamentosDtoRequest> body) {
        return agendamentoService.buscaAgendamentosPorDadosPaciente(body);
    }

    @GetMapping("/marca/realizado")
    public void marcaAgendamentoComoRealizado(@RequestParam Long agendamentoId){
        agendamentoService.marcaAgendamentoComoRealizado(agendamentoId);
    }

    @GetMapping("/marca/cancelado")
    public void marcaAgendamentoComoCancelado(@RequestParam Long agendamentoId){
        agendamentoService.marcaAgendamentoComoCancelado(agendamentoId);
    }

    @GetMapping("/busca/consultas-paciente")
    public List<HistoricoAgendamentosResponse> buscaHistoricoAgendamentos(@RequestParam Long pacienteId){
        return agendamentoService.buscaHistoricoAgendamentos(pacienteId);
    }
}
