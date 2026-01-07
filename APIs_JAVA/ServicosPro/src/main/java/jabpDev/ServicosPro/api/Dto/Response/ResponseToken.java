package jabpDev.ServicosPro.api.Dto.Response;


import io.swagger.v3.oas.annotations.media.Schema;

@Schema(description = "Token gerado depois de validar as credenciais")
public record ResponseToken(String token) {
}
