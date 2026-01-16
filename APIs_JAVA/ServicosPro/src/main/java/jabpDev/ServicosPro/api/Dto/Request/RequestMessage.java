package jabpDev.ServicosPro.api.Dto.Request;

public record RequestMessage(
        Long usuarioFrom, Long usuarioTo, String message
) {
}
