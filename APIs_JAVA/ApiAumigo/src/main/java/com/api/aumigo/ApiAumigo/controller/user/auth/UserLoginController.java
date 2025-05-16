package com.api.aumigo.ApiAumigo.controller.user.auth;


import com.api.aumigo.ApiAumigo.dto.TokenDtoResponse;
import com.api.aumigo.ApiAumigo.dto.login.UserDtoLogin;
import com.api.aumigo.ApiAumigo.exceptions.ErrorExeception;
import com.api.aumigo.ApiAumigo.exceptions.InvalidObjectException;
import com.api.aumigo.ApiAumigo.exceptions.ObjectEmptyException;
import com.api.aumigo.ApiAumigo.models.Users;
import com.api.aumigo.ApiAumigo.repository.UserRepository;
import com.api.aumigo.ApiAumigo.service.user.UserLoginService;
import jakarta.validation.Valid;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@RequestMapping("/loginuser")
public class UserLoginController {
    private final UserLoginService userLoginService;
    private final UserRepository userRepository;

    String token;

    public UserLoginController(UserLoginService userLoginService, UserRepository userRepository) {
        this.userLoginService = userLoginService;
        this.userRepository = userRepository;
    }

    @GetMapping
    public TokenDtoResponse login(@Valid @ModelAttribute UserDtoLogin userDtoLogin) {
//        if (userDtoLogin.email().isEmpty() || userDtoLogin.password().isEmpty()) {
//            throw new ObjectEmptyException("E-mail ou senha não informados");
//        }
        try {
            token = userLoginService.login(userDtoLogin.email(), userDtoLogin.password());
            if (token.isEmpty()) {
                throw new InvalidObjectException("Erro ao realizar login");
            } else {
                return new TokenDtoResponse("Login realizado com sucesso", token);
            }
        } catch (Exception e) {
            throw new ErrorExeception(e);
        }
    }


}
