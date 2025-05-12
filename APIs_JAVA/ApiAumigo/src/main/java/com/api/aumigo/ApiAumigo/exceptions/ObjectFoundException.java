package com.api.aumigo.ApiAumigo.exceptions;


import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class ObjectFoundException extends RuntimeException {
    private int status = 302;
    private String error;
    public ObjectFoundException(String message) {
        super(message);
        this.error = message;
    }
}
