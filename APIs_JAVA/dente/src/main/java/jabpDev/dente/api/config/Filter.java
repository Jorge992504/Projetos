package jabpDev.dente.api.config;

import lombok.Getter;
import lombok.Setter;
import org.springframework.stereotype.Component;

@Getter
@Setter
@Component
public class Filter {
    public String register = "/registrar/empresa";
    public String login = "/login";
    public String redefine = "/redefine";
    public String publicResource  = "/public";

    public String pix = "/plano/pix";
    public String pixStatus = "/plano/pix-status";

    public String card = "/plano/card";
    public String cardStatus = "/plano/card-status";
    public String cardPublicKey = "/plano/public-key";
    public String precoFind = "/preco/find";
}
