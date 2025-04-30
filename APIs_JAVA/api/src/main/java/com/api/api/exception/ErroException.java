package com.api.api.exception;


import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class ErroException extends RuntimeException {
    public ErroException(String msg) {
        super(msg);
    }
}
