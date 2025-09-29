package jabp.chat.api.websocket;

import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

@Configuration
@EnableWebSocket
@RequiredArgsConstructor
public class WebSocketConfig implements WebSocketConfigurer {

    private final WebSocketController webSocketController;
//    private final AuthHandshakeInterceptor authHandshakeInterceptor;

    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
        String path ="/chat";
        registry.addHandler(webSocketController, path)
//                .addInterceptors(authHandshakeInterceptor)
                .setAllowedOrigins("*");
    }
}
