package com.jorge.ws.service;


import org.springframework.boot.autoconfigure.security.oauth2.resource.OAuth2ResourceServerProperties;
import org.springframework.stereotype.Service;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

//###################################
//Gerencia sessões e envia messages
//####################################




@Service
public class WebSocketService {
    ///chat entre dois usuarios so
//########################################################################################################################
//    private static final ConcurrentHashMap<String, WebSocketSession> clients = new ConcurrentHashMap<>();
//
//    public static void registerClient(String clientId, WebSocketSession session){
//        clients.put(clientId,session);
//    }
//
//    public static void removeClient(String clientId){
//        clients.remove(clientId);
//    }
//
//    public static void sendMessageToClient(String clientId, String msg) throws Exception{
//        WebSocketSession session = clients.get(clientId);
//        if (session != null && session.isOpen()){
//            session.sendMessage(new TextMessage(msg));
//        }
//    }
//
//    public static String getClientIdFromToken(String token){
//        return token;
//    }
//########################################################################################################################



//########################################################################################################################
    // Armazena os clientes privados por ID (token)
    private static final ConcurrentHashMap<String, WebSocketSession> clients = new ConcurrentHashMap<>();

    // Armazena os participantes da sala comum
    private static final Set<WebSocketSession> salaComum = ConcurrentHashMap.newKeySet();

    /** ======================= CLIENTES PRIVADOS ======================= **/

    // Registra um cliente privado
    public static void registerClient(Long clientId, WebSocketSession session) {
        clients.put(String.valueOf(clientId), session);
    }

    // Remove um cliente privado
    public static void removeClient(String clientId) {
        clients.remove(clientId);
    }

    // Envia uma mensagem para um cliente específico (chat privado)
    public static void sendMessageToClient(String clientId, String msg) throws Exception {
        WebSocketSession session = clients.get(clientId);
        if (session != null && session.isOpen()) {
            session.sendMessage(new TextMessage(msg));
        }
    }

    // Simula extração do clientId a partir do token (por simplicidade)
    public static Long getClientIdFromToken(Long token) {
        return token;
    }

    /** ======================= SALA COMUM ======================= **/

    // Registra um cliente na sala comum
    public static void registerToSalaComum(WebSocketSession session) {
        salaComum.add(session);
    }

    // Remove um cliente da sala comum
    public static void removeFromSalaComum(WebSocketSession session) {
        salaComum.remove(session);
    }

    // Envia uma mensagem para todos os participantes da sala comum
    public static void broadcastToSalaComum(String message) throws Exception {
        for (WebSocketSession session : salaComum) {
            if (session.isOpen()) {
                session.sendMessage(new TextMessage(message));
            }
        }
    }

}
