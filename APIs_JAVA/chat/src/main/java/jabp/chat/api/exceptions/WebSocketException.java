package jabp.chat.api.exceptions;


import lombok.AllArgsConstructor;

@AllArgsConstructor
public class WebSocketException extends RuntimeException {
    public WebSocketException(String exceptionMessage){
        super(exceptionMessage);
    }
}
