package com.api.aumigo.ApiAumigo.dto;

import java.util.Date;

public record RegisterDto(String email, String name, String telefone, String tipo, String date, String password) {
}
