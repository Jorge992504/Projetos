package com.compras.api.controller.auth;


import com.compras.api.api.dto.request.RequestRegisterUserDto;
import com.compras.api.api.dto.response.ResponseRegisterUserDto;
import com.compras.api.api.exception.ErrorException;
import com.compras.api.api.models.Users;
import com.compras.api.services.auth.ServiceRegisterUser;
import jakarta.validation.Valid;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/register")
public class RegisterUser {

    private final ServiceRegisterUser serviceRegisterUser;

    public RegisterUser(ServiceRegisterUser serviceRegisterUser){
        this.serviceRegisterUser
                = serviceRegisterUser;
    }

    @PostMapping
    public ResponseRegisterUserDto registerUser(@RequestBody RequestRegisterUserDto body){
        if (body.email().isEmpty() || body.password().isEmpty()){
            throw new ErrorException("EmptyObject");
        }
        boolean userExist = serviceRegisterUser.verificaUser(body.email());
        if (userExist){
            throw new ErrorException("ObjectFound");
        }else{
            Users saveUser = serviceRegisterUser.saveUser(body);
            if (saveUser.getId() > 0){
                //envia email com codigo de verificação
                return new ResponseRegisterUserDto("Usuário cadastrado com sucesso");
            }else{
                throw new ErrorException("Internal Error");
            }
        }
    }
}
