package jabpDev.ServicosPro.api.Controllers.Geral;

import jabpDev.ServicosPro.api.Dto.Response.ResponseUsuario;
import jabpDev.ServicosPro.api.Services.Geral.ServiceUsuario;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@AllArgsConstructor
@RequestMapping("/user")
public class ControllerUsuario {

    private ServiceUsuario serviceUsuario;

    @GetMapping("/search/info")
    public ResponseUsuario buscarDadosUsuario(){
        return serviceUsuario.buscarDadosUsuario();
    }

}
