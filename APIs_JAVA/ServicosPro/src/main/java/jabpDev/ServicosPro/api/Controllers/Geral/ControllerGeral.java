package jabpDev.ServicosPro.api.Controllers.Geral;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;
import jabpDev.ServicosPro.api.Services.Geral.ServicosGeral;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

@RestController
@RequestMapping("/controller")
@AllArgsConstructor
public class ControllerGeral {

    private final ServicosGeral servicosGerais;

    @GetMapping
    public ResponseEntity<String> controllerGeral(){
        String token = Jwts.builder()
                .setIssuedAt(new Date(System.currentTimeMillis()))
                .setExpiration(Date.from(LocalDateTime.now().plusDays(servicosGerais.getTimeExpirationToken()).atZone(ZoneId.systemDefault()).toInstant()))
                .signWith(Keys.hmacShaKeyFor(servicosGerais.getSecretKey().getBytes()), SignatureAlgorithm.HS256)
                .compact();
        return ResponseEntity.ok("Requesição realizada com sucesso");
    }
}
//eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3Njc4MDgzNDEsImV4cCI6MTc2ODQxMzE0MX0.xw3hWYhOO0F4Q9WlR0XRn0EVnpQrh8QJR82jxvt_ZZU