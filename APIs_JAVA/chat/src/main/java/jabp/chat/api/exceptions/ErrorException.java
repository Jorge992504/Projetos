package jabp.chat.api.exceptions;


import lombok.AllArgsConstructor;

@AllArgsConstructor
public class ErrorException extends RuntimeException {
    public ErrorException(String message) {
        super(message);
    }
}
