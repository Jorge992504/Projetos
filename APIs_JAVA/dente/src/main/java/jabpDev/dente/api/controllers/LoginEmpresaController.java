package jabpDev.dente.api.controllers;


import jabpDev.dente.api.dto.response.TokenDtoResponse;
import jabpDev.dente.api.repositories.EmpresaRepository;
import jabpDev.dente.api.services.LoginEmpresaService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;

@RestController
@AllArgsConstructor
@RequestMapping("/login")
public class LoginEmpresaController {
    private final LoginEmpresaService loginEmpresaService;

    @GetMapping
    public TokenDtoResponse login(@RequestParam String email, @RequestParam String password) {
        return new TokenDtoResponse(loginEmpresaService.login(email, password));
    }
}
