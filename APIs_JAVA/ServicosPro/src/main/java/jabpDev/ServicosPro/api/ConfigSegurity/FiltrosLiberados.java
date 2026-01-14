package jabpDev.ServicosPro.api.ConfigSegurity;

import lombok.Getter;
import org.springframework.stereotype.Component;

@Getter
@Component
public class FiltrosLiberados {
    public String registrar = "/auth/register";
    public String login = "/auth/login";
    public String receberEmail = "/auth/red/email";
    public String validarCodigo = "/auth/red/cod/val";
    public String redefinirSenha = "/auth/red/password";
    public String validarConexao = "/controller/auth/valid/cone";
}
