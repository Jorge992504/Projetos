package com.compras.api.api.dto.request;

import com.compras.api.api.models.Users;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public record RequestRegisterUserDto(
        @Email(message = "E-mail obrigatorio")
        String email,
        @NotBlank(message = "Senha obrigatoria")
        String password,
        String name) {
}
