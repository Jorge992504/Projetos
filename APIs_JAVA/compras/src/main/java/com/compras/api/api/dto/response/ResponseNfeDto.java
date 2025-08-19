package com.compras.api.api.dto.response;

import com.compras.api.api.models.Users;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

public record ResponseNfeDto(
        LocalDateTime dataTime,
        float unit,
        String un,
        String descricao,
        int qtde,
        String empresa,
        float vlTotal
        ) {
}
