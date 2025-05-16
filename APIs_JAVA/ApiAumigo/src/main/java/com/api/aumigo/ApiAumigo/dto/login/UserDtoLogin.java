package com.api.aumigo.ApiAumigo.dto.login;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;

public record UserDtoLogin(
        @NotBlank @Email String email,
        @NotBlank String password) {
}
