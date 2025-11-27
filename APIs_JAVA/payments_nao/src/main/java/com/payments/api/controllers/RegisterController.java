package com.payments.api.controllers;


import com.payments.api.customexception.CustomException;
import com.payments.api.dto.request.RequestRegisterDto;
import com.payments.api.dto.response.ResponseRegisterDto;
import com.payments.api.models.Users;
import com.payments.api.services.GerarServices;
import com.payments.api.services.RegisterService;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/register")
public class RegisterController {

    private final RegisterService registerService;
    private final GerarServices gerarServices;

    public RegisterController(RegisterService registerService, GerarServices gerarServices) {
        this.registerService = registerService;
        this.gerarServices = gerarServices;
    }

    @PostMapping
    public ResponseRegisterDto registerUser(@RequestBody RequestRegisterDto body){
        if (body.email().isEmpty() || body.password().isEmpty()){
            throw new CustomException(404,"OBJECT_IS_EMPTY","Informe o E-mail e a senha");
        }else{
            Users users = registerService.saveUser(body);
            return new ResponseRegisterDto("Usuário cadastrado",gerarServices.gerarToken(users.getEmail()));
        }
    }
}
