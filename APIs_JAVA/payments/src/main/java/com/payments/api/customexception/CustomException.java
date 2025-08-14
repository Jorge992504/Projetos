package com.payments.api.customexception;


import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class CustomException extends RuntimeException {
    private int status;
    private String erro;
    public CustomException(int status, String erro,String message){
        super(message);
        this.erro = erro;
        this.status = status;
    }
}
