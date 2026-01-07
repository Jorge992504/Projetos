package jabpDev.ServicosPro.api.ConfigSegurity;

import lombok.Getter;
import org.springframework.stereotype.Component;

@Getter
@Component
public class FiltrosLiberados {
    public String registrar = "/auth/register";
    public String login = "/auth/login";
    public String redefinirSenha = "/auth/red/password";
}
