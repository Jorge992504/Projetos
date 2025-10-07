package jabpDev.dente.api.controllers;


import jabpDev.dente.api.dto.response.RedefinirSenhaDtoResponse;
import jabpDev.dente.api.services.RedefinirSenhaService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@AllArgsConstructor
@RequestMapping("/redefine")
public class RedefinirSenhaController {
    private final RedefinirSenhaService redefinirSenhaService;

    @GetMapping
    public void enviarCodigoRedefinirSenha(@RequestParam String email){
        redefinirSenhaService.enviarCodigoRedefinirSenha(email);
    }
}
