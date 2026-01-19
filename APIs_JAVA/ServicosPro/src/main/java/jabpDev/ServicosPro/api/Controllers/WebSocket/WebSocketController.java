package jabpDev.ServicosPro.api.Controllers.WebSocket;

import com.fasterxml.jackson.databind.ObjectMapper;
import jabpDev.ServicosPro.api.Dto.Request.RequestMessage;
import jabpDev.ServicosPro.api.Dto.Response.ResponseMessage;
import jabpDev.ServicosPro.api.Entitys.Usuario;
import jabpDev.ServicosPro.api.Exceptions.CustomExeception.CustomException;
import jabpDev.ServicosPro.api.Repositorys.RepositoryUsuario;
import jabpDev.ServicosPro.api.Services.Geral.ServicosGeral;
import jabpDev.ServicosPro.api.Services.WebSocket.WebSocketService;
import lombok.AllArgsConstructor;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@RestController
@AllArgsConstructor
@MessageMapping("/chat")
public class WebSocketController extends TextWebSocketHandler {

    private ObjectMapper objectMapper = new ObjectMapper();
    private ServicosGeral servicosGeral;
    private WebSocketService webSocketService;
    private RepositoryUsuario repositoryUsuario;

    @Override
    public void afterConnectionEstablished(WebSocketSession socketSession)throws Exception{
        try{
            String email = servicosGeral.getTokenFromHeaders(socketSession);
            Optional<Usuario> usuarioFrom = Optional.ofNullable(repositoryUsuario.findByEmail(email).orElseThrow(() -> new CustomException("Usuário não encontrado")));;
            webSocketService.registrarUsuarioSession(usuarioFrom.get().getId(), socketSession);
            ObjectMapper objectMapper = new ObjectMapper();
            Map<String, String> connected = new HashMap<>();
            connected.put("status", "connected");
            String json = objectMapper.writeValueAsString(connected);
            socketSession.sendMessage(new TextMessage(json));
        }catch (Exception e){
            System.out.println("Conexão não estabelecida, afterConnectionEstablished: " + e.getMessage());
            return;
        }
    }

    @Override
    public void handleTextMessage(WebSocketSession socketSession, TextMessage message)throws Exception{
        try{
            String email = servicosGeral.getTokenFromHeaders(socketSession);
            Optional<Usuario> usuarioFrom = Optional.ofNullable(repositoryUsuario.findByEmail(email).orElseThrow(() -> new CustomException("Usuário não encontrado")));
            RequestMessage payload = objectMapper.readValue(message.getPayload(), RequestMessage.class);
            ResponseMessage responseMessage = new ResponseMessage(
                    usuarioFrom.get().getId(),
                    payload.message()
            );
            webSocketService.sendMessage(responseMessage, payload.usuarioTo());
        }catch (Exception e){
            System.out.println("Problema ao enviar message, handleTextMessage: " + e.getMessage());
            throw new CustomException("Erro ao enviar mensagem");
        }
    }

    @Override
    public void afterConnectionClosed(WebSocketSession socketSession, CloseStatus closeStatus)throws Exception{
        String email = servicosGeral.getTokenFromHeaders(socketSession);
        Optional<Usuario> usuarioFrom = Optional.ofNullable(repositoryUsuario.findByEmail(email).orElseThrow(() -> new CustomException("Usuário não encontrado")));;
        webSocketService.removerUsuarioSession(usuarioFrom.get().getId());
    }
}
