package jabpDev.ServicosPro.api.Controllers.Auth;

import jabpDev.ServicosPro.api.Dto.Response.ResponseToken;
import jabpDev.ServicosPro.api.Services.Auth.ServiceLoginUsuario;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@AllArgsConstructor
@RequestMapping("/auth/login")
public class ControllerLoginUsuario {

    private final ServiceLoginUsuario serviceLoginUsuario;

    @GetMapping
    public ResponseToken login(@RequestParam String email, @RequestParam String password){
        return new ResponseToken(serviceLoginUsuario.login(email,password));
    }

}
