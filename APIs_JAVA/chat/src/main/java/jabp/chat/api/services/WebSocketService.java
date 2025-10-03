package jabp.chat.api.services;


import com.fasterxml.jackson.databind.ObjectMapper;
import jabp.chat.api.dto.request.MessageDtoRequest;
import jabp.chat.api.dto.response.MessageDtoResponse;
import jabp.chat.api.exceptions.WebSocketException;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import java.io.IOException;
import java.util.concurrent.ConcurrentHashMap;

@Service
@AllArgsConstructor
public class WebSocketService {

    private static final ConcurrentHashMap<String, WebSocketSession> clients = new ConcurrentHashMap<>();


    public static void registerClient(String clientId, WebSocketSession session){
        clients.put(clientId,session);
    }

    public static void removeClient(String clientId){
        if (clientId.isEmpty() || clientId == null){
            return;
        }else{
            clients.remove(clientId);
        }

    }

    public static void sendMessageToClient(String clientSend, MessageDtoRequest messageDtoRequest) throws IOException {
        WebSocketSession sessionReceiver = clients.get(messageDtoRequest.userReceiver());
        WebSocketSession session = clients.get(clientSend);
        if (session != null && session.isOpen()){
            MessageDtoRequest messageDtoRequestSender = new MessageDtoRequest(clientSend, messageDtoRequest.userReceiver(), messageDtoRequest.message(), messageDtoRequest.isPick());
            ObjectMapper objectMapper = new ObjectMapper();
            String json = objectMapper.writeValueAsString(messageDtoRequestSender);
            sessionReceiver.sendMessage(new TextMessage(json));
        }else{
            throw new WebSocketException("Erro ao enviar mensagem.");
        }
    }

    public static String getClientEmailFromToken(String token){
        return token;
    }

}
