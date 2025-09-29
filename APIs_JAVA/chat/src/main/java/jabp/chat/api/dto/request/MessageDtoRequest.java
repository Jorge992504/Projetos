package jabp.chat.api.dto.request;


public record MessageDtoRequest(String userSender, String userReceiver, String message) {
}
