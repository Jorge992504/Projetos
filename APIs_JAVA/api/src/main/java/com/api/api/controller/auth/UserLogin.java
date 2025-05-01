package com.api.api.controller.auth;


import com.api.api.Dto.LoginDto;
import com.api.api.Dto.TokenResponseDto;
import com.api.api.exception.EmptyObjectException;
import com.api.api.exception.ObjectNotFoundException;
import com.api.api.repositories.UserRepository;
import com.api.api.services.UserLoginService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/login")
public class UserLogin {

    private final UserRepository userRepository;
    private final UserLoginService service;

    public UserLogin(UserRepository userRepository, UserLoginService service) {
        this.userRepository = userRepository;
        this.service = service;
    }

    @GetMapping
    public TokenResponseDto login(@RequestParam String email, @RequestParam String password ) {
        if (email.isEmpty() || password.isEmpty()){
            throw new EmptyObjectException("Parametros vazios");
        }
        LoginDto param = new LoginDto(email,password);
        String response = service.login(param);
        if (response == null){
            throw new ObjectNotFoundException("Usuário ou senha incorretos");
        }else{
            return new TokenResponseDto(response,"Sucesso ao relaizar login");
        }
    }
}
