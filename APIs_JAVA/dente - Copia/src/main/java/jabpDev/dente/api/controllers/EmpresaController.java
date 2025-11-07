package jabpDev.dente.api.controllers;

import jabpDev.dente.api.dto.request.RegistrarEmpresaDtoRequest;
import jabpDev.dente.api.dto.response.EmpresaDtoResponse;
import jabpDev.dente.api.services.EmpresaService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@AllArgsConstructor
@RequestMapping("/empresa")
public class EmpresaController {

    private final EmpresaService empresaService;


    @GetMapping("/find")
    public EmpresaDtoResponse buscaInfoEmpresa(){
        return empresaService.buscaInfoEmpresa();
    }

    @PostMapping("/editar")
    public void editarDadosEmpresa(@RequestBody RegistrarEmpresaDtoRequest body){
        empresaService.editarDadosEmpresa(body);
    }
}
