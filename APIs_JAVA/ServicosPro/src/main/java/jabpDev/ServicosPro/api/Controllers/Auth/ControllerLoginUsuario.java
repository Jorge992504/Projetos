package jabpDev.ServicosPro.api.Controllers.Auth;

import jabpDev.ServicosPro.api.Dto.Request.RequestCodigo;
import jabpDev.ServicosPro.api.Dto.Request.RequestUsuario;
import jabpDev.ServicosPro.api.Dto.Response.ResponseToken;
import jabpDev.ServicosPro.api.Services.Auth.ServiceLoginUsuario;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@AllArgsConstructor
@RequestMapping("/auth")
public class ControllerLoginUsuario {

    private final ServiceLoginUsuario serviceLoginUsuario;

    @GetMapping("/login")
    public ResponseToken login(@RequestParam String email, @RequestParam String password){
        return new ResponseToken(serviceLoginUsuario.login(email,password));
    }

    @GetMapping("/red/email")
    public void enviarCodigo(@RequestParam String email){
        serviceLoginUsuario.enviarCodigo(email);
    }

    @GetMapping("/red/cod/val")
    public ResponseEntity<?> validarCodigo(@RequestParam int codigo, @RequestParam String email){
        return ResponseEntity.ok(serviceLoginUsuario.validarCodigo(codigo,email));
    }

    @GetMapping("/red/password")
    public ResponseEntity<?> redefinirSenha(@RequestParam String email, @RequestParam String senha){
        return ResponseEntity.ok(serviceLoginUsuario.redefinirSenha(email,senha));
    }

}
