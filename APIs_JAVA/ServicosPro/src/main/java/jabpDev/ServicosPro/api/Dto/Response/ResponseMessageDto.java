package jabpDev.ServicosPro.api.Dto.Response;

import java.time.LocalDateTime;

public record ResponseMessageDto(
        Long id,
        Long usuarioFrom,
        Long usuarioTo,
        String message,
        LocalDateTime dateTime,
        String foto
) {
}
