package jabpDev.ServicosPro.api.Controllers.Geral;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;
import jabpDev.ServicosPro.api.Dto.Request.RequestCategorias;
import jabpDev.ServicosPro.api.Services.Geral.ServicosGeral;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;

@RestController
@RequestMapping("/controller")
@AllArgsConstructor
public class ControllerGeral {

    private final ServicosGeral servicosGerais;

    @GetMapping("/valid/token")
    public void validarToken(@RequestHeader("Authorization") String header){
        servicosGerais.validarTokenAuth(header);
    }
}