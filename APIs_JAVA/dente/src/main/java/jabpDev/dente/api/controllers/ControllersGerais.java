package jabpDev.dente.api.controllers;

import jabpDev.dente.api.services.ServicesGerais;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/controllers")
@AllArgsConstructor
public class ControllersGerais {

    private final ServicesGerais servicesGerais;

    @GetMapping("/validar-token")
    public ResponseEntity<?> validarTokenGeral(@RequestHeader("Authorization") String header){
        return servicesGerais.validarTokenGeral(header);
    }
}
