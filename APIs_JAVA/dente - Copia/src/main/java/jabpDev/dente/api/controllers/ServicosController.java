package jabpDev.dente.api.controllers;


import jabpDev.dente.api.dto.request.RegistrarServicosDtoRequest;
import jabpDev.dente.api.dto.response.BuscarServicosDtoResponse;
import jabpDev.dente.api.services.ServicosService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@AllArgsConstructor
@RequestMapping("/servicos")
public class ServicosController {

    private final ServicosService servicosService;

    @PostMapping("/registrar")
    public void registrarServicosClinica(@RequestBody RegistrarServicosDtoRequest body){
        servicosService.registrarServicosClinica(body);
    }

    @GetMapping("/buscar")
    public List<BuscarServicosDtoResponse> buscarServicos(){
        return servicosService.buscarServicos();
    }
}
