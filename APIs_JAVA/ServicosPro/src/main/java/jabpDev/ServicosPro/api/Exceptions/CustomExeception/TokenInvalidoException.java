package jabpDev.ServicosPro.api.Exceptions.CustomExeception;

public class TokenInvalidoException extends RuntimeException {
    public TokenInvalidoException(String message) {
        super(message);
    }
}
