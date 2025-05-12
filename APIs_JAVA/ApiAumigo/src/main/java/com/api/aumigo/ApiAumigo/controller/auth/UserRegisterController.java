package com.api.aumigo.ApiAumigo.controller.auth;


import com.api.aumigo.ApiAumigo.dto.RegisterDto;
import com.api.aumigo.ApiAumigo.exceptions.ErrorExeception;
import com.api.aumigo.ApiAumigo.exceptions.InvalidObjectException;
import com.api.aumigo.ApiAumigo.exceptions.ObjectFoundException;
import com.api.aumigo.ApiAumigo.models.Users;
import com.api.aumigo.ApiAumigo.repository.UserRepository;
import com.api.aumigo.ApiAumigo.service.UserRegisterService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/registeruser")
public class UserRegisterController {
    private final UserRegisterService userRegisterService;

    public UserRegisterController(UserRegisterService userRegisterService) {
        this.userRegisterService = userRegisterService;
    }

    @PostMapping
    public ResponseEntity<?> registerUser(@RequestBody RegisterDto body) {
        if (body.email().isEmpty() && body.password().isEmpty()) {
            throw new InvalidObjectException("E-mail e senha obrigatorios");
        }
        String email = body.email();
        boolean userExist = userRegisterService.verificaUser(email);
        if (userExist) {
            throw new ObjectFoundException("Usuário já cadastrado");
        } else {
            Users save = userRegisterService.saveUser(body);
            if (save.getId() > 0) {
                return ResponseEntity.status(200).body("Usuário cadastrado com sucesso");

            }else{
                throw new ErrorExeception("Erro ao registrar usuário");
            }
        }
    }

}
