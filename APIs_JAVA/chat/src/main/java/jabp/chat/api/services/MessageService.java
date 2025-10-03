package jabp.chat.api.services;


import jabp.chat.api.dto.request.MessageSendDtoRequest;
import jabp.chat.api.dto.response.HistoricoMessagesDtoResponse;
import jabp.chat.api.dto.response.MessageDtoResponse;
import jabp.chat.api.entitys.Message;
import jabp.chat.api.entitys.Usuario;
import jabp.chat.api.exceptions.ErrorException;
import jabp.chat.api.repositorio.HistoricoMessageRepository;
import jabp.chat.api.repositorio.UsuarioRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.io.EOFException;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class MessageService {

    private final HistoricoMessageRepository historicoMessageRepository;
    private final UsuarioRepository usuarioRepository;
    private static final String url = "http://172.20.10.7:8082/api/public/";


    @Transactional
    public Message sendMessage(MessageSendDtoRequest messageSendDtoRequest) throws IOException {
        Usuario usuario = (Usuario) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Usuario usuarioSender = usuarioRepository.findByEmail(usuario.getEmail())
                .orElseThrow(() -> new RuntimeException("Usuário remetente não encontrado " + messageSendDtoRequest.senderEmail()));
        Usuario usuarioReceiver = usuarioRepository.findByEmail(messageSendDtoRequest.receiverEmail())
                .orElseThrow(() -> new RuntimeException("Usuário destinatário não encontrado "+ messageSendDtoRequest.receiverEmail()));
        Message msg = new Message();

        if (Boolean.TRUE.equals(messageSendDtoRequest.isPick()) && !messageSendDtoRequest.image().isEmpty()){

            //define diretorio para salvar
            Path diretory = Path.of("src/main/resources/static/public/"+messageSendDtoRequest.senderEmail());
            if (!Files.exists(diretory)){
                Files.createDirectories(diretory);
            }

            //Gera nome da imagem
            String fileName = UUID.randomUUID()+".png";
            Path filePath = diretory.resolve(fileName);

            //salva a imagem
            Files.copy(messageSendDtoRequest.image().getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
            msg.setContent(url+messageSendDtoRequest.senderEmail()+fileName);
        }else{
            msg.setContent(messageSendDtoRequest.message());
        }

        msg.setSender(usuarioSender);
        msg.setReceiver(usuarioReceiver);
        msg.setSentAt(LocalDateTime.now());
        msg.setIsPick(messageSendDtoRequest.isPick());
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
                    return new HistoricoMessagesDtoResponse(senderEmail, receiverEmail, content, sentAt, msg.getIsPick(),null);
                })
                .collect(Collectors.toList());
    }

    public List<HistoricoMessagesDtoResponse> getConversation(String userFrom) throws IOException {
        try{
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
                        msg.getSentAt(),
                        msg.getIsPick(),null
                );
            }).collect(Collectors.toList());
        }catch (ErrorException e){
            throw new ErrorException("Erro ao buscar conversas");
        }
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
