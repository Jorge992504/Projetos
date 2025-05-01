package com.api.api.exception;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class ObjectNotFoundException extends RuntimeException {
    private int status = 404;
    private String error;
    public ObjectNotFoundException(String msg) {
        super("Not Found");
        this.error = msg;
    }
}
