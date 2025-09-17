package com.jabpdev.cadastro_usuario.controller;

import com.jabpdev.cadastro_usuario.dto.request.LoginRequest;
import com.jabpdev.cadastro_usuario.dto.response.LoginResponse;
import com.jabpdev.cadastro_usuario.services.LoginService;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.oauth2.jwt.JwtEncoder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@AllArgsConstructor
@RequestMapping("/login")
public class LoginController {

    private final LoginService loginService;

    @PostMapping
    public ResponseEntity<LoginResponse> login(@RequestBody LoginRequest loginRequest){
        String accessToken = loginService.login(loginRequest);
        if (accessToken == null){
            throw new RuntimeException("Usuário não encontrado ou senha incorreta");
        }else{
           return ResponseEntity.ok(new LoginResponse(accessToken));
        }
    }
}
