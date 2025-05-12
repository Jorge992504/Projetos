package com.api.aumigo.ApiAumigo.exceptions;


import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class ErrorExeception extends RuntimeException {
    private int status = 404;
    private String error;
    public ErrorExeception(String message) {
        super("Not Register");
        this.error = message;
    }
}
