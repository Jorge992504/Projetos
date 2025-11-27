package jabpDev.dente.api.controllers;


import jabpDev.dente.api.services.PremiumService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@AllArgsConstructor
@RequestMapping("/premium")
public class PremiumController {

    private final PremiumService premiumService;

    @GetMapping("/status")
    public boolean verificaPremium(){
        return premiumService.verificaPremium();
    }
}
