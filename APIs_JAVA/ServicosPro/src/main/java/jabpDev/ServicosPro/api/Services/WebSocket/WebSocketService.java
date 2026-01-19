package jabpDev.ServicosPro.api.Services.WebSocket;

import com.fasterxml.jackson.databind.ObjectMapper;
import jabpDev.ServicosPro.api.Dto.Request.RequestMessage;
import jabpDev.ServicosPro.api.Dto.Response.ResponseMessage;
import jabpDev.ServicosPro.api.Exceptions.CustomExeception.CustomException;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import java.util.concurrent.ConcurrentHashMap;

@Service
@AllArgsConstructor
public class WebSocketService {

    private static ConcurrentHashMap<Long, WebSocketSession> usuarios = new ConcurrentHashMap<>();

    public void registrarUsuarioSession(Long usuarioId, WebSocketSession socketSession)throws Exception{
        try{
            usuarios.put(usuarioId, socketSession);
        }catch (Exception e){
            System.out.println("Conexão não estabelecida: " + e.getMessage());
            throw new CustomException("Sem conexão");
        }
    }
    public void removerUsuarioSession(Long usuarioId)throws Exception{
        try{
            usuarios.remove(usuarioId);
        }catch (Exception e ){
            System.out.println("Conexão não encerrada: " + e.getMessage());
        }
    }
    public void sendMessage(ResponseMessage message, Long usuarioTo)throws Exception{
        try{
            WebSocketSession socketSessionTo = usuarios.get(usuarioTo);
            ObjectMapper objectMapper = new ObjectMapper();
            String json = objectMapper.writeValueAsString(message);
            socketSessionTo.sendMessage(new TextMessage(json));
        }catch (Exception e){
            System.out.println(e.getMessage());
            throw new CustomException("Não foi possível enviar a mensagem");
        }
    }
}
