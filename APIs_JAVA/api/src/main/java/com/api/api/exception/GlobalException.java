package com.api.api.exception;


import jakarta.servlet.http.HttpServletRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import java.time.Instant;
import java.util.HashMap;
import java.util.Map;

@ControllerAdvice
public class GlobalException {

    @ExceptionHandler(EmptyObjectException.class)
    public ResponseEntity<?> handleEmptyObjectException(EmptyObjectException ex, HttpServletRequest request) {

        //Map<String, Object> response = new HashMap<>();
        //response.put("status", HttpStatus.NOT_FOUND.value());
        //response.put("error", ex.getMessage());
        //response.put("message", HttpStatus.BAD_REQUEST);

        Map<String, Object> response = new HashMap<>();
        response.put("status", ex.getStatus());
        response.put("error", ex.getError());
        response.put("message", ex.getMessage());


        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
    }


    @ExceptionHandler(ObjectFoundException.class)
    public  ResponseEntity<?> handleObjectFoundException(ObjectFoundException ex, HttpServletRequest request){
        Map<String, Object> response = new HashMap<>();
        response.put("Status", ex.getStatus());
        response.put("Error", ex.getError());
        response.put("Message", ex.getMessage());

        return  ResponseEntity.status(HttpStatus.FOUND).body(response);
    }

    @ExceptionHandler(ErroException.class)
    public ResponseEntity<?> handleErroException(ErroException ex, HttpServletRequest request){
        Map<String, Object> response = new HashMap<>();
        response.put("Status", HttpStatus.NOT_FOUND.value());
        response.put("Message", ex.getMessage());

        return  ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
    }
}
