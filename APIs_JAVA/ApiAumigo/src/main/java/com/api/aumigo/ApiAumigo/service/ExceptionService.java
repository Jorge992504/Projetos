package com.api.aumigo.ApiAumigo.service;


import com.api.aumigo.ApiAumigo.exceptions.*;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.context.support.DefaultMessageSourceResolvable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;

@ControllerAdvice
public class ExceptionService {

    @ExceptionHandler(InvalidObjectException.class)
    public ResponseEntity<?> handleInvalidObjectException(InvalidObjectException invalidObjectException, HttpServletRequest request){
        Map<String, Object> response = new HashMap<>();
        response.put("status: ", invalidObjectException.getStatus());
        response.put("error: ", invalidObjectException.getError());
        response.put("message: ", invalidObjectException.getMessage());

        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
    }


    @ExceptionHandler(ObjectFoundException.class)
    public ResponseEntity<?> handleObjectFoundException(ObjectFoundException objectFoundException, HttpServletRequest request){
        Map<String, Object> response = new HashMap<>();
        response.put("status: ", objectFoundException.getStatus());
        response.put("error: ", objectFoundException.getError());
        response.put("message: ", objectFoundException.getMessage());

        return ResponseEntity.status(HttpStatus.FOUND).body(response);
    }

    @ExceptionHandler(ErrorExeception.class)
    public ResponseEntity<?> handleErrorExeception(ErrorExeception errorExeception, HttpServletRequest request){
        Map<String, Object> response = new HashMap<>();
        response.put("status: ", errorExeception.getStatus());
        response.put("error: ",HttpStatus.INTERNAL_SERVER_ERROR );
        response.put("message: ", errorExeception.getError().getMessage());

        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
    }

    @ExceptionHandler(RegisterException.class)
    public ResponseEntity<?> handleRegisterError(RegisterException registerError, HttpServletRequest request){
        Map<String, Object> response = new HashMap<>();
        response.put("status: ", registerError.getStatus());
        response.put("error: ", registerError.getError());
        response.put("message: ", registerError.getMessage());

        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
    }

    @ExceptionHandler(ObjectEmptyException.class)
    public ResponseEntity<?> handleObjectEmptyException(ObjectEmptyException objectEmptyException){
        Map<String, Object> response = new HashMap<>();
        response.put("status: ", objectEmptyException.getStatus());
        response.put("error: ", objectEmptyException.getError());
        response.put("message: ", objectEmptyException.getMessage());

        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
    }

    //exception para o dto
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<?> handleBodyException(MethodArgumentNotValidException exception){
        Map<String, Object> response = new HashMap<>();
        Map<String, String> fieldErrors = exception.getBindingResult()
                .getFieldErrors()
                .stream()
                .collect(Collectors.toMap(
                        FieldError::getField,               // campo com erro, ex: "email"
                        DefaultMessageSourceResolvable::getDefaultMessage,      // mensagem, ex: "deve ser um endereço de e-mail bem formado"
                        (existing, replacement) -> existing      // em caso de campos repetidos
                ));

        response.put("status", HttpStatus.BAD_REQUEST.value());
        response.put("message", "Erro de validação");
        response.put("errors", fieldErrors);

        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
    }

}
