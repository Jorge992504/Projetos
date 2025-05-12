package com.api.aumigo.ApiAumigo.exceptions;


import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class InvalidObjectException extends RuntimeException {
    private int status = 400;
    private String error;

    public InvalidObjectException(String message) {
        super("Object Found");
        this.error = message;


    }
}
