package com.api.api.exception;


import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class ObjectFoundException extends RuntimeException {
    private int status = 200;
    private String error;
    public ObjectFoundException(String msg) {
        super("Found");
        this.error = msg;
    }
}
