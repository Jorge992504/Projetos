package jabpDev.dente.api.exceptions;


import lombok.Getter;

@Getter
public class ErrorException extends RuntimeException {
    public ErrorException(String message) {
        super(message);
    }
}
