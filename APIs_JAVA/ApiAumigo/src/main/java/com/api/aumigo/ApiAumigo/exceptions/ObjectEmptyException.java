package com.api.aumigo.ApiAumigo.exceptions;


import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class ObjectEmptyException extends RuntimeException {
    private int status = 400;
    private String error;
    public ObjectEmptyException(String message) {
        super("PARAMETRO_VAZIO");
        this.error = message;
    }
}
