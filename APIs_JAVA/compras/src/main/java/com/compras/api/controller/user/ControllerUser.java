package com.compras.api.controller.user;


import java.util.Optional;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.compras.api.api.dto.response.ResponseUserDto;
import com.compras.api.api.exception.ErrorException;
import com.compras.api.api.models.Users;
import com.compras.api.services.user.ServiceUser;

@RestController
@RequestMapping("/user")
public class ControllerUser {

    private final ServiceUser serviceUser;

    public ControllerUser(ServiceUser serviceUser) {
        this.serviceUser = serviceUser;
    }

    @GetMapping
    public ResponseUserDto getUser() {
        Users u = (Users) SecurityContextHolder.getContext().getAuthentication().getPrincipal(); //contexto para pegar o email do token
        Optional<Users> user = serviceUser.getUser(u.getEmail());
        if (user.isPresent()) {
            return new ResponseUserDto(user.get().getId(),user.get().getEmail(),user.get().getName());
        } else {
            throw new ErrorException("Usuário não encontrado");
        }
    }

}
