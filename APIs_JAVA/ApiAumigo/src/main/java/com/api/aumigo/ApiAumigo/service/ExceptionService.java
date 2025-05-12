package com.api.aumigo.ApiAumigo.service;


import com.api.aumigo.ApiAumigo.exceptions.ErrorExeception;
import com.api.aumigo.ApiAumigo.exceptions.InvalidObjectException;
import com.api.aumigo.ApiAumigo.exceptions.ObjectFoundException;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import java.util.HashMap;
import java.util.Map;

@ControllerAdvice
public class ExceptionService {

    @ExceptionHandler(InvalidObjectException.class)
    public ResponseEntity<?> handleInvalidObjectException(InvalidObjectException invalidObjectException, HttpServletRequest request){
        Map<String, Object> response = new HashMap<>();
        response.put("Status: ", invalidObjectException.getStatus());
        response.put("Error: ", invalidObjectException.getError());
        response.put("Message: ", invalidObjectException.getMessage());

        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
    }


    @ExceptionHandler(ObjectFoundException.class)
    public ResponseEntity<?> handleObjectFoundException(ObjectFoundException objectFoundException, HttpServletRequest request){
        Map<String, Object> response = new HashMap<>();
        response.put("Status: ", objectFoundException.getStatus());
        response.put("Error: ", objectFoundException.getError());
        response.put("Message: ", objectFoundException.getMessage());

        return ResponseEntity.status(HttpStatus.FOUND).body(response);
    }

    @ExceptionHandler(ErrorExeception.class)
    public ResponseEntity<?> handleErrorExeception(ErrorExeception errorExeception, HttpServletRequest request){
        Map<String, Object> response = new HashMap<>();
        response.put("Status: ", errorExeception.getStatus());
        response.put("Error: ", errorExeception.getError());
        response.put("Message: ", errorExeception.getMessage());

        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
    }

}
