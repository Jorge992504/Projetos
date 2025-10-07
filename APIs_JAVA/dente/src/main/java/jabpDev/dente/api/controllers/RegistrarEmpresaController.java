package jabpDev.dente.api.controllers;

import jabpDev.dente.api.dto.request.RegistrarEmpresaDtoRequest;
import jabpDev.dente.api.dto.response.TokenDtoResponse;
import jabpDev.dente.api.exceptions.ErrorException;
import jabpDev.dente.api.services.RegistrarEmpresaService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;

@RestController
@RequestMapping("/registrar/empresa")
@AllArgsConstructor
public class RegistrarEmpresaController {

    private final RegistrarEmpresaService registrarEmpresaService;

    @PostMapping
    public TokenDtoResponse registrarEmpresa(@RequestBody RegistrarEmpresaDtoRequest body) throws IOException {
        if (body.emailClinica().isEmpty()){
            throw new ErrorException("Campos mal informados");
        }else{
            return new TokenDtoResponse(registrarEmpresaService.registrarEmpresa(body));
        }
    }
}
