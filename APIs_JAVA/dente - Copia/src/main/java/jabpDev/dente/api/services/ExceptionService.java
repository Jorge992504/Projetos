package jabpDev.dente.api.services;

import jabpDev.dente.api.exceptions.ErrorException;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import java.util.HashMap;
import java.util.Map;

@ControllerAdvice
public class ExceptionService {

    @ExceptionHandler(ErrorException.class)
    public ResponseEntity<?> handleErrorException(ErrorException errorException, HttpServletRequest request){
        Map<String, Object> response = new HashMap<>();
        response.put("message", errorException.getMessage());

        return ResponseEntity.status(HttpStatus.EXPECTATION_FAILED).body(response);
    }
}
