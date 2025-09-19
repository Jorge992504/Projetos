package jabp.chat.api.exceptions;


import lombok.AllArgsConstructor;

@AllArgsConstructor
public class AuthorizationException extends RuntimeException{
    public AuthorizationException(String exceptionMessage){
        super(exceptionMessage);
    }
}
