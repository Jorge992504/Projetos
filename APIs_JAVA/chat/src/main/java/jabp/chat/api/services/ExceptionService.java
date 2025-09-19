package jabp.chat.api.services;

import jabp.chat.api.exceptions.AuthorizationException;
import jabp.chat.api.exceptions.ErrorException;
import jabp.chat.api.exceptions.WebSocketException;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import java.util.HashMap;
import java.util.Map;

@ControllerAdvice
public class ExceptionService {
    @ExceptionHandler(AuthorizationException.class)
    public ResponseEntity<?> handleAuthorizationException(AuthorizationException authorizationException, HttpServletRequest request){
        Map<String, Object> response = new HashMap<>();
        response.put("exceptionMessage", authorizationException.getMessage());
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response);
    }

    @ExceptionHandler(WebSocketException.class)
    public ResponseEntity<?> handleWebSocketException(WebSocketException webSocketException, HttpServletRequest request){
        Map<String, Object> response = new HashMap<>();
        response.put("exceptionMessage", webSocketException.getMessage());
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
    }

    @ExceptionHandler(ErrorException.class)
    public ResponseEntity<?> handleErrorException(ErrorException errorException, HttpServletRequest request){
        Map<String, Object> response = new HashMap<>();
        response.put("message", errorException.getMessage());
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
    }
}
