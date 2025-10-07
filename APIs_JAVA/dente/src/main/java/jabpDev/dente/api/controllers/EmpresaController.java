package jabpDev.dente.api.controllers;

import jabpDev.dente.api.dto.response.EmpresaDtoResponse;
import jabpDev.dente.api.services.EmpresaService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;

@RestController
@AllArgsConstructor
@RequestMapping("/empresa")
public class EmpresaController {

    private final EmpresaService empresaService;


    @GetMapping("/find")
    public EmpresaDtoResponse buscaInfoEmpresa()throws IOException {
        return empresaService.buscaInfoEmpresa();
    }
}
