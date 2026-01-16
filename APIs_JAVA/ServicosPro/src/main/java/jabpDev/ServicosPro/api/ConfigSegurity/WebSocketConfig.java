package jabpDev.ServicosPro.api.ConfigSegurity;


import jabpDev.ServicosPro.api.Controllers.WebSocket.WebSocketController;
import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

@Configuration
@EnableWebSocket
@AllArgsConstructor
public class WebSocketConfig implements WebSocketConfigurer {
    private  WebSocketController webSocketController;

    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry webSocketHandlerRegistry){
        String path = "/chat";
        webSocketHandlerRegistry.addHandler(webSocketController, path).setAllowedOrigins("*");
    }
}
