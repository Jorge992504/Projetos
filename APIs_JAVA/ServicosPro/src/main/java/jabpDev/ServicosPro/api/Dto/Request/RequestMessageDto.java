package jabpDev.ServicosPro.api.Dto.Request;

import jabpDev.ServicosPro.api.Entitys.Usuario;
import jakarta.persistence.Column;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;

import java.time.LocalDateTime;

public record RequestMessageDto(
        Long usuarioTo,
        String message,
        LocalDateTime dateTime,
        String foto
) {
}
