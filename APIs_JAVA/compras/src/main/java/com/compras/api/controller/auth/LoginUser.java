package com.compras.api.controller.auth;


import com.compras.api.api.dto.response.ResponseLoginUserDto;
import com.compras.api.api.dto.response.ResponseTokenDto;
import com.compras.api.api.exception.ErrorException;
import com.compras.api.services.auth.ServiceLoginUser;
import com.compras.api.services.auth.ServiceRegisterUser;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/login")
public class LoginUser {
    private final ServiceLoginUser serviceLoginUser;

    public LoginUser(ServiceLoginUser serviceLoginUser){
        this.serviceLoginUser = serviceLoginUser;
    }

    @GetMapping
    public ResponseTokenDto loginUser(@RequestParam String email, @RequestParam String password){
        if (email.isEmpty() || password.isEmpty()){
            throw new ErrorException("EmptyObjecy",400,"E-mail e senha obrigatorios");
        }else{
            ResponseLoginUserDto loginUserDto = new ResponseLoginUserDto(email,password);
            String response = serviceLoginUser.loginUser(loginUserDto);
            if (response == null){
                throw new ErrorException("ObjectNotFound",404,"Usuário ou senha incorretos");
            }else{
                return new ResponseTokenDto(response,"Sucesso ao realizar login");
            }
        }
    }
}
