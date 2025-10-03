package jabpdev.nahora.api.config;

import lombok.Getter;
import lombok.Setter;
import org.springframework.stereotype.Component;

@Getter
@Setter
@Component
public class Filter {
    public String register = "/register";
    public String login = "/login";
    public String redefine = "/redefine";
    public String publicResource  = "/public";
    public String promocoes = "/promocoes/gerais";
    public String menu = "/menu";
}
