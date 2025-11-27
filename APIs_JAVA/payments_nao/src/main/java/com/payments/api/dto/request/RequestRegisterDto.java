package com.payments.api.dto.request;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;

public record RequestRegisterDto(
        @Email(message = "E-mail obrigatorio")
        String email,
        @NotBlank(message = "Senha obrigatoria")
        String password,
        String name) {
}
