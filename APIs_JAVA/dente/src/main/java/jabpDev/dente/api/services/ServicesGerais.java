package jabpDev.dente.api.services;


import io.jsonwebtoken.*;
import io.jsonwebtoken.security.Keys;
import jabpDev.dente.api.exceptions.ErrorException;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Service
public class ServicesGerais {

    @Value("${jwt.secret}")
    private String secretKey;
    @Value("${jwt.expiration}")
    private Long expirationTokenTime;

    private final JavaMailSender javaMailSender;

    public ServicesGerais(JavaMailSender javaMailSender){
        this.javaMailSender = javaMailSender;
    }


    public String geraToken(String email){
        Map<String, Object> claims = new HashMap<>();
        claims.put("email",email);
        return Jwts.builder().setClaims(claims)
                .setIssuedAt(new Date(System.currentTimeMillis()))
                .setExpiration(Date.from(LocalDateTime.now().plusDays(expirationTokenTime).atZone(ZoneId.systemDefault()).toInstant()))
                .signWith(Keys.hmacShaKeyFor(secretKey.getBytes()), SignatureAlgorithm.HS256)
                .compact();
    }


    public Claims validarToken(String token) {
        try {
            return Jwts.parserBuilder()
                    .setSigningKey(Keys.hmacShaKeyFor(secretKey.getBytes()))
                    .build()
                    .parseClaimsJws(token)
                    .getBody();
        } catch (ExpiredJwtException e) {
            throw new ErrorException("Token expirado");
        } catch (JwtException e) {
            throw new ErrorException("Token inválido");
        }
    }

    public void enviarEmailRedefinirSenha(String destinatario, int codigo) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(destinatario);
        message.setSubject("Código de verificação para redefinir sua senha.\nEste é um e-mail automatico, não precisa responder.");
        message.setText("Código de verificação: " + codigo);
        javaMailSender.send(message);
    }
}
