package jabpDev.dente.api.controllers;


import jabpDev.dente.api.dto.request.RegistrarDentistaDtoRequest;
import jabpDev.dente.api.dto.response.BuscaDentistasDtoResponse;
import jabpDev.dente.api.services.DentistaService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@AllArgsConstructor
@RequestMapping("/dentista")
public class DentistaController {

    private final DentistaService dentistaService;

    @PostMapping("/registrar")
    public void registrarDentista(@RequestBody RegistrarDentistaDtoRequest body){
        dentistaService.registrarDentista(body);
    }

    @GetMapping("/buscar")
    public List<BuscaDentistasDtoResponse> buscaDentistas(){
        return dentistaService.buscaDentistas();
    }
}
