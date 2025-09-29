package jabp.chat.api.services;


import jabp.chat.api.dto.request.MessageSendDtoRequest;
import jabp.chat.api.dto.response.HistoricoMessagesDtoResponse;
import jabp.chat.api.dto.response.MessageDtoResponse;
import jabp.chat.api.entitys.Message;
import jabp.chat.api.entitys.Usuario;
import jabp.chat.api.repositorio.HistoricoMessageRepository;
import jabp.chat.api.repositorio.UsuarioRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class MessageService {

    private final HistoricoMessageRepository historicoMessageRepository;
    private final UsuarioRepository usuarioRepository;


    @Transactional
    public Message sendMessage(MessageSendDtoRequest messageSendDtoRequest) {
        Usuario usuario = (Usuario) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Usuario usuarioSender = usuarioRepository.findByEmail(usuario.getEmail())
                .orElseThrow(() -> new RuntimeException("Usuário remetente não encontrado " + messageSendDtoRequest.senderEmail()));
        Usuario usuarioReceiver = usuarioRepository.findByEmail(messageSendDtoRequest.receiverEmail())
                .orElseThrow(() -> new RuntimeException("Usuário destinatário não encontrado "+ messageSendDtoRequest.receiverEmail()));
        Message msg = new Message();

        msg.setSender(usuarioSender);
        msg.setReceiver(usuarioReceiver);
        msg.setContent(messageSendDtoRequest.message());
        msg.setSentAt(LocalDateTime.now());
        return historicoMessageRepository.save(msg);
    }

    public List<HistoricoMessagesDtoResponse> buscaMessages(String userFrom) {
        Usuario usuario = (Usuario) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Usuario from = usuarioRepository.findByEmail(userFrom)
                .orElseThrow(() -> new RuntimeException("Usuário remetente não encontrado"));
        List<Message> messages = historicoMessageRepository.findBySenderIdAndReceiverIdOrSenderIdAndReceiverIdOrderBySentAtAsc(usuario.getId(), from.getId(), from.getId(), usuario.getId());
        return messages.stream()
                .map(msg -> {
                    String senderEmail = msg.getSender().getEmail();
                    String receiverEmail = msg.getReceiver().getEmail();
                    String content = msg.getContent();
                    LocalDateTime sentAt = msg.getSentAt();
                    return new HistoricoMessagesDtoResponse(senderEmail, receiverEmail, content, sentAt);
                })
                .collect(Collectors.toList());
    }

    public List<HistoricoMessagesDtoResponse> getConversation(String userFrom) {
        Usuario usuario = (Usuario) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Usuario from = usuarioRepository.findByEmail(userFrom)
                .orElseThrow(() -> new RuntimeException("Usuário remetente não encontrado"));
           List<Message> messages = historicoMessageRepository
                .findBySenderIdAndReceiverIdOrSenderIdAndReceiverIdOrderBySentAtAsc(
                        usuario.getId(), from.getId(), from.getId(), usuario.getId()
                );
           return messages.stream().map(msg ->{
               return new HistoricoMessagesDtoResponse(
                       msg.getSender().getEmail(),
                       msg.getReceiver().getEmail(),
                       msg.getContent(),
                       msg.getSentAt()
               );
           }).collect(Collectors.toList());
    }


    public List<MessageDtoResponse> getMessagesOfUser() {
        Usuario usuario = (Usuario) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        List<Message> mensagens = historicoMessageRepository.findAllBySenderIdOrderBySentAtDesc(usuario.getId());
        Map<String, Message> ultimasMensagens = mensagens.stream()
                .sorted((a, b) -> b.getSentAt().compareTo(a.getSentAt())) // mais recente primeiro
                .collect(Collectors.toMap(
                        m -> m.getReceiver().getEmail(),
                        m -> m,
                        (existing, replacement) -> existing, // mantém a primeira (mais recente)
                        LinkedHashMap::new
                ));
        // Converte para DTO
        return ultimasMensagens.entrySet().stream()
                .map(entry -> new MessageDtoResponse(entry.getValue().getId(), entry.getKey(), entry.getValue().getContent()))
                .collect(Collectors.toList());
    }
}
