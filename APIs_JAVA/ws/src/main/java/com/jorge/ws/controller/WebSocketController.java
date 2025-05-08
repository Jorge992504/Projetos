package com.jorge.ws.controller;


import com.fasterxml.jackson.databind.ObjectMapper;
import com.jorge.ws.model.MsgDto;
import com.jorge.ws.service.WebSocketService;
import org.springframework.stereotype.Controller;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;


//#############################
//Ponto de entrada do WebSocket
//#############################

@Controller
public class WebSocketController extends TextWebSocketHandler {

    //so para chat entre dois
//########################################################################################################################
//    private final ObjectMapper objectMapper = new ObjectMapper();
//
//    @Override
//    public void afterConnectionEstablished(WebSocketSession session)throws Exception{
//        String token = getTokenFromHeaders(session);
//        if (token == null){
//            session.close(CloseStatus.BAD_DATA);
//            return;
//        }
//
//        String clientId = WebSocketService.getClientIdFromToken(token);
//        WebSocketService.registerClient(clientId,session);
//        System.out.println("Cliente " + clientId + " conectado.");
//    }
//
//    @Override
//    public void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
//        String token = getTokenFromHeaders(session);
//        String from = WebSocketService.getClientIdFromToken(token);
//
//        MsgDto msg = objectMapper.readValue(message.getPayload(), MsgDto.class);
//        String to = msg.getTo();
//        String text = msg.getMsg();
//
//        String msgToSend = "De: " + from + " -> " + text;
//        WebSocketService.sendMessageToClient(to, msgToSend);
//    }
//
//    @Override
//    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
//        String token = getTokenFromHeaders(session);
//        String clientId = WebSocketService.getClientIdFromToken(token);
//        WebSocketService.removeClient(clientId);
//        System.out.println("Cliente " + clientId + " desconectado.");
//    }
//
//    private String getTokenFromHeaders(WebSocketSession session) {
//        return session.getHandshakeHeaders().getFirst("Authorization");
//    }
//########################################################################################################################

//########################################################################################################################
    private final ObjectMapper objectMapper = new ObjectMapper();

    // Sala comum - lista de sessões conectadas em /chatComum
    private static final Map<Long,WebSocketSession> salaComum = new HashMap<>();

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        String token = getTokenFromHeaders(session);
        if (token == null) {
            session.close(CloseStatus.BAD_DATA);
            return;
        }
        var id = WebSocketService.getClientIdFromToken(Long.valueOf(token));

        String path = session.getUri().getPath();

        if ("/chatComum".equals(path)) {

            salaComum.put(id,session);

            session.sendMessage(new TextMessage("Conectado à sala comum."));
        } else {
            Long clientId = WebSocketService.getClientIdFromToken(Long.valueOf(token));
            WebSocketService.registerClient(clientId, session);
            session.sendMessage(new TextMessage("Conectado como cliente " + clientId + "."));
        }
    }

    @Override
    public void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        String token = getTokenFromHeaders(session);
        Long from = WebSocketService.getClientIdFromToken(Long.valueOf(token));
        MsgDto msg = objectMapper.readValue(message.getPayload(), MsgDto.class);

        String path = session.getUri().getPath();

        if ("/chatComum".equals(path)) {
            // Broadcast para todos da sala comum
            String broadcast = "SalaComum - " + from + ": " + msg.getMsg();
            for (WebSocketSession s : salaComum.values()) {
                if (s.isOpen()) {
                    s.sendMessage(new TextMessage(broadcast));
                }
            }
        } else {
            // Enviar para um cliente específico
            String to = msg.getTo();
            String text = msg.getMsg();
            String msgToSend = "De: " + from + " -> " + text;
            WebSocketService.sendMessageToClient(to, msgToSend);
        }
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        String token = getTokenFromHeaders(session);
        Long clientId = WebSocketService.getClientIdFromToken(Long.valueOf(token));

        String path = session.getUri().getPath();

        if ("/chatComum".equals(path)) {
            salaComum.remove(session);
        } else {
            WebSocketService.removeClient(String.valueOf(clientId));
        }
    }

    private String getTokenFromHeaders(WebSocketSession session) {
        return session.getHandshakeHeaders().getFirst("Authorization");
    }

}
