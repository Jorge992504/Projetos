package com.compras.api.api.exception;


import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class ErrorException extends RuntimeException {
private int status;
private String error;
    public ErrorException(String msg, int status,String error){
        super(msg);
        this.status = status;
        this.error =error;
    }
}
