package jabp.chat.api.dto.request;

import org.springframework.web.multipart.MultipartFile;

public record MessageSendDtoRequest(String senderEmail, String receiverEmail, String message, Boolean isPick, MultipartFile image) {
}
