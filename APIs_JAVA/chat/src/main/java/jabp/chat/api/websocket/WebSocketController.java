package jabp.chat.api.websocket;


import com.fasterxml.jackson.databind.ObjectMapper;
import jabp.chat.api.dto.request.MessageDtoRequest;
import jabp.chat.api.dto.response.MessageDtoResponse;
import jabp.chat.api.exceptions.WebSocketException;
import jabp.chat.api.services.MessageService;
import jabp.chat.api.services.WebSocketService;
import lombok.AllArgsConstructor;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.util.HashMap;
import java.util.Map;

@Controller
@AllArgsConstructor
@MessageMapping("/chat")
//@SendTo
public class WebSocketController extends TextWebSocketHandler {


    private final ObjectMapper objectMapper = new ObjectMapper();

    @Override
    public void afterConnectionEstablished(WebSocketSession session)throws Exception{
        String cliente = getEmailFromHeaders(session);
        if (cliente == null){
            session.close(CloseStatus.BAD_DATA);
            return;
        }
        WebSocketService.registerClient(cliente, session);
        System.out.println("Cliente " + cliente + " conectado.");
        if (session.isOpen()) {
            ObjectMapper mapper = new ObjectMapper();
            Map<String, String> connectMsg = new HashMap<>();
            connectMsg.put("status", "connected");
            String json = mapper.writeValueAsString(connectMsg);
            session.sendMessage(new TextMessage(json));
        }
    }

    @Override
    public void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {


//        String token = getTokenFromHeaders(session);
        String clientSend = getEmailFromHeaders(session);

        MessageDtoRequest messageDtoRequest = objectMapper.readValue(message.getPayload(), MessageDtoRequest.class);

        System.out.println(clientSend +" "+ messageDtoRequest.message());
        WebSocketService.sendMessageToClient( clientSend, messageDtoRequest);
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        String cliente = getEmailFromHeaders(session);
        WebSocketService.removeClient(cliente);
        System.out.println("Cliente " + cliente + " desconectado.");
    }

    private String getEmailFromHeaders(WebSocketSession session) {
        return session.getHandshakeHeaders().getFirst("Authorization");
    }

}
