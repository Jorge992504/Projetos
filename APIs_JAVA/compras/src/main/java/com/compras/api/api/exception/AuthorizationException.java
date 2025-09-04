package com.compras.api.api.exception;

import lombok.AllArgsConstructor;

@AllArgsConstructor
public class AuthorizationException extends RuntimeException {
    public AuthorizationException(String message) {
        super(message);
    }
}
