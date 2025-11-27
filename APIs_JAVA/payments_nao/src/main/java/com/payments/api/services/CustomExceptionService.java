package com.payments.api.services;


import com.payments.api.customexception.CustomException;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

@RestControllerAdvice
public class CustomExceptionService {
    @ExceptionHandler(CustomException.class)
    public ResponseEntity<?> handlerCustomException(CustomException e, HttpServletRequest request){
        Map<String, Object> response = new HashMap<>();
        response.put("message", e.getMessage());
        response.put("erro", e.getErro());
        response.put("status", e.getStatus());
        return ResponseEntity.ok().body(response);
    }
}
