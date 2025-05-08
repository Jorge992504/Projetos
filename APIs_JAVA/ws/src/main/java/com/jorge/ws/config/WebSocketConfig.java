package com.jorge.ws.config;


import com.jorge.ws.controller.WebSocketController;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;


//############################
//Configuração do WebSocket
//############################


@Configuration
@EnableWebSocket
public class WebSocketConfig implements WebSocketConfigurer {

    //rota para chat entre dois usuarios
//###########################################################################################################################
    //registra o endpoint e permite os origins(ajustes em produção)
//    @Override
//    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry){
//        registry.addHandler(new com.jorge.ws.controller.WebSocketController(), "/chat")
//                .setAllowedOrigins("*");
//
//    }
//##############################################################################################################################

    // Registra os endpoints do WebSocket e permite qualquer origem (ajuste isso em produção)
    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
        WebSocketController handler = new WebSocketController();

        // Chat privado
        registry.addHandler(handler, "/chat")
                .setAllowedOrigins("*");

        // Sala de chat comum (broadcast)
        registry.addHandler(handler, "/chatComum")
                .setAllowedOrigins("*");
    }

}
