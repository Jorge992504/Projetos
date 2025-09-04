package com.compras.api.services;


import com.compras.api.api.exception.AuthorizationException;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.util.HashMap;
import java.util.Map;

@RestControllerAdvice
public class AuthorizationExceptionService {
    @ExceptionHandler(AuthorizationException.class)
    public ResponseEntity<?> handleErrorException(AuthorizationException errorException, HttpServletRequest request){
        Map<String, Object> response = new HashMap<>();

//        response.put("status", errorException.getStatus());
        response.put("message", errorException.getMessage());
//        response.put("error", errorException.getError());

        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response);
    }
}
