package com.api.aumigo.ApiAumigo.exceptions;


import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class ErrorExeception extends RuntimeException {
    private int status = 500;
    private Exception error;
    public ErrorExeception( Exception e) {
        super("Internal Server Error");
        this.error = e;
    }
}
