package com.compras.api.api.dto.response;

import com.compras.api.api.models.Users;

public record ResponseLoginUserDto(String email, String password) {
}
