package jabpDev.ServicosPro.api.Exceptions.GlobalExeception;


import jabpDev.ServicosPro.api.Exceptions.CustomExeception.CustomException;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

import java.util.HashMap;
import java.util.Map;

@ControllerAdvice
public class ControllerException extends ResponseEntityExceptionHandler {

    @ExceptionHandler(CustomException.class)
    public ResponseEntity<?> handleCustomException(CustomException exception, HttpServletRequest request){
        Map<String, Object> response = new HashMap<>();
        response.put("message", exception.getMessage());
        return ResponseEntity.status(404).body(response);
    }
}
