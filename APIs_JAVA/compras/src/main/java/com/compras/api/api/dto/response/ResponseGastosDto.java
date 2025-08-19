package com.compras.api.api.dto.response;

import java.time.LocalDateTime;

public record ResponseGastosDto(LocalDateTime dateTime, String empresa, float vlTotal) {
}
