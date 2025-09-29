package jabp.chat.api.controller;

import jabp.chat.api.dto.request.MessageSendDtoRequest;
import jabp.chat.api.dto.response.HistoricoMessagesDtoResponse;
import jabp.chat.api.dto.response.MessageDtoResponse;
import jabp.chat.api.entitys.Message;
import jabp.chat.api.exceptions.ErrorException;
import jabp.chat.api.services.MessageService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/messages")
public class MessageController {

    private final MessageService messageService;

    @GetMapping
    public List<HistoricoMessagesDtoResponse> getConversation(
            String userFrom
    ) {
        return messageService.getConversation(userFrom);
    }

    @GetMapping("/ofuser")
    public List<MessageDtoResponse> getMessagesOfUser() {
        try {
            return messageService.getMessagesOfUser();
        } catch (Exception e) {
            throw new ErrorException("Erro ao buscar mensagens do usuário: " + e.getMessage());
        }
    }

    @PostMapping("/send")
    public ResponseEntity<?> sendMessage(@RequestBody MessageSendDtoRequest messageSendDtoRequest) {
        try {
            Message response = messageService.sendMessage(messageSendDtoRequest);
            if (response.getId() == null) {
                throw new ErrorException("Erro ao enviar mensagem");
            }else{
                return ResponseEntity.status(200).build();
            }
        } catch (Exception e) {
            throw new ErrorException("Erro ao enviar mensagem: " + e.getMessage());
        }
    }

}
