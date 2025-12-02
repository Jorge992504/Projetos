package jabpDev.dente.api.controllers;


import jabpDev.dente.api.services.PlanoService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@AllArgsConstructor
@RequestMapping("/plano")
public class PlanoController {

    private final PlanoService planoService;

    @GetMapping("/status")
    public String verificaPlano(){
        return planoService.verificaPlano();
    }
}
