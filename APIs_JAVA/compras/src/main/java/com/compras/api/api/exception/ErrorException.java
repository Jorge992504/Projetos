package com.compras.api.api.exception;


import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
//@AllArgsConstructor
public class ErrorException extends RuntimeException {

//    private String message;
    public ErrorException(String message) {
        super(message);
    }

}
