package com.compras.api.services;


import com.compras.api.api.exception.ErrorException;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

@ControllerAdvice
public class ExceptionService {
    @ExceptionHandler(ErrorException.class)
    public ResponseEntity<?> handleErrorException(ErrorException errorException, HttpServletRequest request){
        Map<String, Object> response = new HashMap<>();

        response.put("status", errorException.getStatus());
        response.put("message", errorException.getMessage());
        response.put("error", errorException.getError());

        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
    }
}
