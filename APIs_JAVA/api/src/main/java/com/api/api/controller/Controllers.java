package com.api.api.controller;


import com.api.api.Dto.TokenResponseDto;
import com.api.api.exception.EmptyObjectException;
import com.api.api.exception.ErroException;
import com.api.api.exception.ObjectNotFoundException;
import com.api.api.models.Users;
import com.api.api.repositories.UserRepository;
<<<<<<< HEAD
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
=======
import com.api.api.services.UserEmailVerificadoService;
import org.springframework.web.bind.annotation.*;
>>>>>>> 46d0cb621f1f7a015a86974f3d155ac9a5db3b65

import java.util.Optional;

@RestController
<<<<<<< HEAD
@RequestMapping("/getUsers")
=======
@RequestMapping("/controller")
>>>>>>> 46d0cb621f1f7a015a86974f3d155ac9a5db3b65
public class Controllers {

    private final UserRepository userRepository;
    private final UserEmailVerificadoService userEmailVerificadoService;

    public Controllers(UserRepository userRepository, UserEmailVerificadoService userEmailVerificadoService) {
        this.userRepository = userRepository;
        this.userEmailVerificadoService = userEmailVerificadoService;
    }

    @GetMapping("/verificar")
    public TokenResponseDto verificaEmail(@RequestParam String email, @RequestParam int codigo) {
        if (email.isEmpty()) {
            throw new EmptyObjectException("Parametros vazios");
        }

        Optional<Users> user = userRepository.findByEmail(email);
        if (user.isPresent()) {
            if (user.get().getCodVerif() == codigo) {
                String token = userEmailVerificadoService.atualizaVerificado(email,codigo);
                if (token == null) {
                    throw new ErroException("Erro ao verificar e-mail");
                } else {
                    return new TokenResponseDto(token, "E-mail verificado com sucesso");
                }
            }
        }
        throw new ObjectNotFoundException("Usuário não encontrado");
    }
}