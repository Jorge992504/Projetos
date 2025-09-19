package jabp.chat.api.services;


import jabp.chat.api.exceptions.WebSocketException;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import java.io.IOException;
import java.util.concurrent.ConcurrentHashMap;

@Service
@AllArgsConstructor
public class WebSocketService {

    private static final ConcurrentHashMap<String, WebSocketSession> clientes = new ConcurrentHashMap<>();

    public static void registraCliente(String email, WebSocketSession socketSession){
        clientes.put(email,socketSession);
    }
    public static void removeCLiente(String email, WebSocketSession socketSession){
       boolean result =  clientes.remove(email,socketSession);
       if (!result){
           throw new WebSocketException("Erro ao se desconetar");
       }

    }
    public static void sendMessageCliente(String email, String message) throws IOException{
        WebSocketSession socketSession = clientes.get(email);
        if (socketSession != null && socketSession.isOpen()){
            socketSession.sendMessage(new TextMessage(message));

        }else{
            throw new WebSocketException("Erro ao enviar mensagem para: "+email);
        }
    }
}
