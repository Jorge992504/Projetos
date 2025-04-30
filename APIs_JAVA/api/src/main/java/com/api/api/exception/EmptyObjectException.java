package com.api.api.exception;


import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class EmptyObjectException extends RuntimeException {
    private int status = 400;
    private String error;
    public EmptyObjectException(String msg){
        super("Empty Object");
        this.error = msg;
    }
}
