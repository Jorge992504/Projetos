package com.api.api.controller.auth;


import com.api.api.Dto.RegistroDto;
import com.api.api.controller.Controllers;
import com.api.api.models.Users;
import com.api.api.repositories.UserRepository;
import com.api.api.services.Services;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Optional;

@RestController
@RequestMapping("/register")

public class RegisterUser {

    private final JdbcTemplate dataBase;

    private UserRepository userRepository;

    private final Services services;

    public RegisterUser(JdbcTemplate dataBase, UserRepository userRepository,Services services) {
        this.dataBase = dataBase;
        this.userRepository = userRepository;
        this.services = services;
    }

    @PostMapping
    public ResponseEntity<?> register(@RequestBody RegistroDto body) throws Exception {

        if (body.email().isEmpty()) {
            return ResponseEntity.status(400).body("Body vazio: " + body.toString());
        }

        String email = body.email();

        boolean userExist = services.verificaUser(email);
        if (userExist){
            return ResponseEntity.status(200).body("Usuario ja existe" + email);
        }else{
            Users save = services.saveUser(body);
            if (save.getId() > 0){
                return  ResponseEntity.status(201).body("Usuario cadastrado com sucesso");
            }else{
                return ResponseEntity.status(402).body("Erro ao cadastrar usuario");
            }

        }


    }




}
