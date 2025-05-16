package com.api.aumigo.ApiAumigo.controller.user.auth;


import com.api.aumigo.ApiAumigo.dto.register.RegisterDto;
import com.api.aumigo.ApiAumigo.dto.register.RegisterDtoResponse;
import com.api.aumigo.ApiAumigo.exceptions.ErrorExeception;
import com.api.aumigo.ApiAumigo.exceptions.ObjectFoundException;
import com.api.aumigo.ApiAumigo.exceptions.RegisterException;
import com.api.aumigo.ApiAumigo.models.Users;
import com.api.aumigo.ApiAumigo.service.EmailService;
import com.api.aumigo.ApiAumigo.service.user.UserRegisterService;
import jakarta.validation.Valid;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/registeruser")
public class UserRegisterController {
    private final UserRegisterService userRegisterService;
    private final EmailService emailService;

    public UserRegisterController(UserRegisterService userRegisterService, EmailService emailService) {
        this.userRegisterService = userRegisterService;
        this.emailService = emailService;
    }

    @PostMapping
    public RegisterDtoResponse registerUser(@Valid @RequestBody RegisterDto body) {
        String email = body.email();
        boolean userExist = userRegisterService.verificaUser(email);
        if (userExist) {
            throw new ObjectFoundException("Usuário já cadastrado");
        }
        try {
            Users save = userRegisterService.saveUser(body);
            if (save.getId() > 0) {
                boolean response = emailService.enviarEmail(save.getEmail(), save.getCodigo());
                if (response) {
                    return new RegisterDtoResponse("Usuário cadastrado com sucesso.", "E-mail enviado com sucessso para: " + save.getEmail());
                } else {
                    throw new RegisterException("Erro ao registrar usuário");
                }
            } else {
                throw new RegisterException("Erro ao registrar usuário");
            }

        } catch (Exception e) {
            throw new ErrorExeception(e);
        }
    }

}
