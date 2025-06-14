package com.api.api.Dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;

public record RegistroDto(
    @Email(message = "E-mail obrigatorio") String email,
    @NotBlank(message = "Senha obrigatoria") String password, 
    String name) {
}
