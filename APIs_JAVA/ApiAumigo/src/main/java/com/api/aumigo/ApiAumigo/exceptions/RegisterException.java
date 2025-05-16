package com.api.aumigo.ApiAumigo.exceptions;


import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class RegisterException extends RuntimeException {
    private int status = 404;
    private String error;
    public RegisterException(String message) {
        super("USER_NOT_REGISTER");
        this.error = message;

    }
}
