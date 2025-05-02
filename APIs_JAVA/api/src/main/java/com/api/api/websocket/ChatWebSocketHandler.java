package com.api.api.websocket;


import com.api.api.Dto.MessageDto;
import com.api.api.services.authorization.AuthorizationService;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.json.JSONObject;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Component
public class ChatWebSocketHandler extends TextWebSocketHandler {

    private final Map<String, WebSocketSession> sessions = new ConcurrentHashMap<>();
    private final AuthorizationService authorizationService;

    public ChatWebSocketHandler(AuthorizationService authorizationService) {
        this.authorizationService = authorizationService;
    }

    @Override
    public void afterConnectionEstablished(WebSocketSession session) {
        String email = authorizationService.getEmailFromSession(session);
        if (email != null && !email.isEmpty()) {
            sessions.put(email, session);
            System.out.println("Conectado: " + email);
        } else {
            System.out.println("Conexão sem email válido, fechando...");
            try {
                session.close(CloseStatus.BAD_DATA);
            } catch (Exception ignored) {}
        }
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        ObjectMapper mapper = new ObjectMapper();
        MessageDto dto = mapper.readValue(message.getPayload(), MessageDto.class);

        String to = dto.to();
        String msg = dto.message();

        WebSocketSession destinatario = sessions.get(to);
        if (destinatario != null && destinatario.isOpen()) {
            destinatario.sendMessage(new TextMessage(msg));
        } else {
            session.sendMessage(new TextMessage("Usuário destino não está online."));
        }
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) {
        sessions.values().removeIf(sess -> sess.getId().equals(session.getId()));
    }
}
