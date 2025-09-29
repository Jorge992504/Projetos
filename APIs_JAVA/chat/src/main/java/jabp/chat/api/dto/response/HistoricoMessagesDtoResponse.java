package jabp.chat.api.dto.response;

import java.time.LocalDateTime;

public record HistoricoMessagesDtoResponse(String userFrom,
                                           String userTo,
                                           String message,
                                           LocalDateTime sentAt) {
}
