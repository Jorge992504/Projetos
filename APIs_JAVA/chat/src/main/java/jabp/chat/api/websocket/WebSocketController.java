package jabp.chat.api.websocket;


import com.fasterxml.jackson.databind.ObjectMapper;
import jabp.chat.api.entitys.MessageDtoRequest;
import jabp.chat.api.services.WebSocketService;
import lombok.AllArgsConstructor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@Controller
@AllArgsConstructor
public class WebSocketController extends TextWebSocketHandler {


    private static final ObjectMapper objectMapper = new ObjectMapper();


    @Override
    public void afterConnectionEstablished(WebSocketSession socketSession)throws Exception {
        String cliente =  SecurityContextHolder.getContext().getAuthentication().getName();
        if (cliente.isEmpty()){
            socketSession.close(CloseStatus.BAD_DATA);
        }else{
            WebSocketService.registraCliente(cliente,socketSession);
            socketSession.sendMessage(new TextMessage("Connection"));
        }
    }

    @Override
    public void handleTextMessage(WebSocketSession socketSession, TextMessage textMessage)throws Exception{
        String userFrom =  SecurityContextHolder.getContext().getAuthentication().getName();
        MessageDtoRequest messageDto = objectMapper.readValue(textMessage.getPayload(), MessageDtoRequest.class);
        String userTo = messageDto.getUserTo();
        String messageToSend = "De: " + userFrom + "\n" +  messageDto.getMessage();
        WebSocketService.sendMessageCliente(userTo,messageToSend);

    }

    @Override
    public void afterConnectionClosed(WebSocketSession socketSession, CloseStatus closeStatus)throws Exception{
        String cliente =  SecurityContextHolder.getContext().getAuthentication().getName();
        WebSocketService.removeCLiente(cliente,socketSession);
    }


}
