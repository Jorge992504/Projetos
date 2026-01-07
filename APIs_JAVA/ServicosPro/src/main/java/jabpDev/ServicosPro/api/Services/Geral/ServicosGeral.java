package jabpDev.ServicosPro.api.Services.Geral;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;
import jabpDev.ServicosPro.api.Exceptions.CustomExeception.TokenInvalidoException;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Service
public class ServicosGeral {

    @Value("${jwt.secret}")
    private String secretKey;
    @Value("${jwt.expiration}")
    private Long timeExpirationToken;
    @Value("${app.base-url}")
    private String urlInterna;

    public Claims validarTokenRequesicao(String token, HttpServletResponse response){
        try{
            return Jwts.parserBuilder()
                    .setSigningKey(Keys.hmacShaKeyFor(secretKey.getBytes()))
                    .build()
                    .parseClaimsJws(token)
                    .getBody();
        }catch (TokenInvalidoException e){
            return  Jwts.claims();
        }
    }

    public String getSecretKey(){
        return secretKey;
    }

    public Long getTimeExpirationToken(){
        return timeExpirationToken;
    }

    public String getUrlInterna(){
        return urlInterna;
    }

    public String gerarToken(String email){
        Map<String,Object> claims = new HashMap<>();
        claims.put("email",email);
        return Jwts.builder().setClaims(claims)
                .setIssuedAt(new Date(System.currentTimeMillis()))
                .setExpiration(Date.from(LocalDateTime.now().plusDays(timeExpirationToken).atZone(ZoneId.systemDefault()).toInstant()))
                .signWith(Keys.hmacShaKeyFor(secretKey.getBytes()), SignatureAlgorithm.HS256)
                .compact();
    }
}
