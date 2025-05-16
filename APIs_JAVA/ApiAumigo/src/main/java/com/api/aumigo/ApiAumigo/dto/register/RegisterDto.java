package com.api.aumigo.ApiAumigo.dto.register;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;

import java.time.LocalDate;

public record RegisterDto(
        @NotBlank @Email String email,
        @NotBlank String name,
        @NotBlank String telefone,
        @NotBlank String password) {
}
