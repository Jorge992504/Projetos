package jabp.chat.api.dto.response;

import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDateTime;

public record HistoricoMessagesDtoResponse(String userFrom,
                                           String userTo,
                                           String message,
                                           LocalDateTime sentAt,
                                           Boolean isPick,
                                           MultipartFile image) {
}
