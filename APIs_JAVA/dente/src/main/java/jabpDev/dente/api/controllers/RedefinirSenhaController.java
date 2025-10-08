package jabpDev.dente.api.controllers;


import jabpDev.dente.api.dto.request.RedefinirSenhaDtoRequest;
import jabpDev.dente.api.services.RedefinirSenhaService;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@AllArgsConstructor
@RequestMapping("/redefine")
public class RedefinirSenhaController {
    private final RedefinirSenhaService redefinirSenhaService;

    @GetMapping
    public void enviarCodigoRedefinirSenha(@RequestParam String email){
        redefinirSenhaService.enviarCodigoRedefinirSenha(email);
    }

    @PostMapping
    public void verificarCodigo(@RequestBody RedefinirSenhaDtoRequest body){
        redefinirSenhaService.verificarCodigo(body);
    }

    @PostMapping("/password")
    public void redefinirSenha(@RequestBody RedefinirSenhaDtoRequest body){
        redefinirSenhaService.redefinirSenha(body);
    }
}
