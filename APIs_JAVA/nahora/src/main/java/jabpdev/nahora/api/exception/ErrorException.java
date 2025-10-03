package jabpdev.nahora.api.exception;


import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
public class ErrorException extends RuntimeException {
    public ErrorException(String message) {
        super(message);
    }
}
