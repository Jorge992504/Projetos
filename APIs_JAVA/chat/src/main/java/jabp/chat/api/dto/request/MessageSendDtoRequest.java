package jabp.chat.api.dto.request;

public record MessageSendDtoRequest(String senderEmail, String receiverEmail, String message) {
}
