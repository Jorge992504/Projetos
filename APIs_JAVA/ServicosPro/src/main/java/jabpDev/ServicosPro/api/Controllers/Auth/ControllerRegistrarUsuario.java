package jabpDev.ServicosPro.api.Controllers.Auth;


import jabpDev.ServicosPro.api.Dto.Request.RequestUsuario;
import jabpDev.ServicosPro.api.Dto.Response.ResponseToken;
import jabpDev.ServicosPro.api.Services.Auth.ServiceRegistrarUsuario;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;

@RestController
@AllArgsConstructor
@RequestMapping("/auth/register")
public class ControllerRegistrarUsuario {

    private final ServiceRegistrarUsuario serviceRegistrarUsuario;

    @PostMapping
    public ResponseToken registrarUsuario(@RequestBody RequestUsuario requestUsuario)throws IOException {
        return new  ResponseToken(serviceRegistrarUsuario.registrarUsuario(requestUsuario));
    }

    @PostMapping("/categoria")
    public ResponseEntity<?> registrarCategoriaUsuario(@RequestBody RequestUsuario requestUsuario){
        return ResponseEntity.ok(serviceRegistrarUsuario.registrarCategoriaUsuario(requestUsuario));
    }
}
