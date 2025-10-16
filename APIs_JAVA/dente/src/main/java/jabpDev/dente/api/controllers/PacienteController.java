package jabpDev.dente.api.controllers;


import jabpDev.dente.api.dto.request.RegistrarPacienteDtoRequest;
import jabpDev.dente.api.dto.response.PacienteCPFDtoResponse;
import jabpDev.dente.api.entitys.Paciente;
import jabpDev.dente.api.services.PacienteService;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@AllArgsConstructor
@RequestMapping("/paciente")
public class PacienteController {

    private final PacienteService pacienteService;

//    @GetMapping("/busca")
//    public List<PacienteCPFDtoResponse> buscaPacientePorCPF(){
//        return pacienteService.buscaPacientePorCPF();
//    }

    @PostMapping("/registrar")
    public ResponseEntity<?> registrarPaciente(@RequestBody RegistrarPacienteDtoRequest body){
        return ResponseEntity.ok(pacienteService.registrarPaciente(body));
    }

}
