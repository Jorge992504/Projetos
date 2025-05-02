package com.api.api.config;


import com.api.api.interceptor.AuthHandshakeInterceptor;
import com.api.api.services.authorization.AuthorizationService;
import com.api.api.websocket.ChatWebSocketHandler;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

@Configuration
@EnableWebSocket
public class WebSocketConfig implements WebSocketConfigurer {

    private final AuthorizationService authorizationService;

    public WebSocketConfig(AuthorizationService authorizationService) {
        this.authorizationService = authorizationService;
    }

    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
        registry
                .addHandler(new ChatWebSocketHandler(authorizationService), "/chat")
                .setAllowedOrigins("*")
                .addInterceptors(new AuthHandshakeInterceptor(authorizationService)); // Adicionando o interceptor
    }
}
