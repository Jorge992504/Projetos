package com.api.api.controller.auth;


import com.api.api.Dto.RegistroDto;
import com.api.api.Dto.TokenResponseDto;
import com.api.api.exception.EmptyObjectException;
import com.api.api.exception.ErroException;
import com.api.api.exception.ObjectFoundException;
import com.api.api.models.Users;
import com.api.api.repositories.UserRepository;
import com.api.api.services.UserRegisterService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/register")

public class UserRegister {


    private UserRepository userRepository;

    private final UserRegisterService services;

    public UserRegister(UserRepository userRepository, UserRegisterService services) {
        this.userRepository = userRepository;
        this.services = services;
    }

    @PostMapping
    public ResponseEntity<?> register(@RequestBody RegistroDto body) {

        if (body.email().isEmpty() || body.password().isEmpty()) {
            throw new EmptyObjectException("Campos vazios");
        }

        String email = body.email();

        boolean userExist = services.verificaUser(email);
        if (userExist) {
            throw new ObjectFoundException("Usuário já cadastrado");
        } else {
            Users save = services.saveUser(body);
            if (save.getId() > 0) {
                //String token = services.geraToken(email, body.password());
                services.enviarEmail(save.getEmail(), save.getCodVerif());

                return ResponseEntity.ok("Usuário cadastrado com sucesso");
            } else {
                throw new ErroException("Erro ao cadastrar usuário");
            }
        }
    }


}
