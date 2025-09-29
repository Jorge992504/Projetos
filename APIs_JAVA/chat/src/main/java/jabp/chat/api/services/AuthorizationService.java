package jabp.chat.api.services;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import jabp.chat.api.exceptions.AuthorizationException;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.Collections;

@Service
public class AuthorizationService {

    @Value("${jwt.secret}")
    private String secretKey;

    public boolean isTokenValid(HttpServletRequest request) throws IOException{
        String header = request.getHeader("Authorization");

        if (header == null || !header.startsWith("Bearer ")){
            return false;
        }
        String token = header.replace("Bearer ","");
        try {
            Claims claims = getClaimsForToken(token);
            String user = claims.getSubject();
            var auth = new UsernamePasswordAuthenticationToken(user, null, Collections.emptyList());
            SecurityContextHolder.getContext().setAuthentication(auth);
            return true;
        }catch (Exception e){
            return false;
        }
    }

    public Claims getClaimsForToken(String token){
        try {
           return Jwts.parserBuilder()
                    .setSigningKey(Keys.hmacShaKeyFor(secretKey.getBytes()))
                    .build()
                    .parseClaimsJws(token)
                    .getBody();
        }catch (ExpiredJwtException e){
            throw new AuthorizationException("Token expirado: "+e.getMessage());
        }catch (JwtException e){
            throw new AuthorizationException("Token invalido: "+e.getMessage());
        }
    }

    public boolean validarToken(String token) {
        try {
            Claims claims = Jwts.parserBuilder()
                    .setSigningKey(Keys.hmacShaKeyFor(secretKey.getBytes()))
                    .build()
                    .parseClaimsJws(token)
                    .getBody();

            // Se chegou aqui, o token é válido e não expirou
            return true;

        } catch (Exception e) {
            // Token inválido ou expirado
            return false;
        }
    }
}
