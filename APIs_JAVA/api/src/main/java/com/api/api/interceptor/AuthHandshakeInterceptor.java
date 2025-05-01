package com.api.api.interceptor;

import com.api.api.services.authorization.AuthorizationService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.server.HandshakeInterceptor;

import java.util.Map;

public class AuthHandshakeInterceptor implements HandshakeInterceptor {

    private final AuthorizationService authorizationService;

    public AuthHandshakeInterceptor(AuthorizationService authorizationService) {
        this.authorizationService = authorizationService;
    }

    @Override
    public boolean beforeHandshake(ServerHttpRequest request,
                                   ServerHttpResponse response,
                                   WebSocketHandler wsHandler,
                                   Map<String, Object> attributes) {
        if (request instanceof ServletServerHttpRequest servletRequest) {
            HttpServletRequest httpRequest = servletRequest.getServletRequest();

            if (!authorizationService.isAuthorized(httpRequest)) {
                return false; // bloqueia o handshake se o token for inválido
            }

            // você pode armazenar o e-mail para reutilizar depois
            String email = authorizationService.getUsernameFromRequest(httpRequest);
            attributes.put("email", email);
        }

        return true; // permite o handshake
    }

    @Override
    public void afterHandshake(ServerHttpRequest request,
                               ServerHttpResponse response,
                               WebSocketHandler wsHandler,
                               Exception exception) {
        // nada necessário aqui por enquanto
    }
}
