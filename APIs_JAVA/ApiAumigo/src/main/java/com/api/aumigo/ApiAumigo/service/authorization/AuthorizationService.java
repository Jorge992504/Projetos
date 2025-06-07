package com.api.aumigo.ApiAumigo.service.authorization;

import com.api.aumigo.ApiAumigo.exceptions.ErrorExeception;
import com.api.aumigo.ApiAumigo.exceptions.InvalidObjectException;
import io.jsonwebtoken.*;
import io.jsonwebtoken.security.Keys;
import jakarta.annotation.PostConstruct;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import javax.crypto.SecretKey;
import java.security.Key;
import java.util.Collections;
import java.util.Date;
import java.util.Optional;

@Service
public class AuthorizationService {

    @Value("${jwt.secretKey}")
    private String secretKey;

    public boolean isAuthorized(HttpServletRequest request) {
        String header = request.getHeader("Authorization");
        if (header == null || !header.startsWith("Bearer ")) {
            return false;
        }

        String token = header.replace("Bearer ", "");

        try {
            Claims claims = Jwts.parserBuilder()
                    .setSigningKey(Keys.hmacShaKeyFor(secretKey.getBytes()))
                    .build()
                    .parseClaimsJws(token)
                    .getBody();

            String email = (String) claims.get("email");
            if (email == null) return false;

            var auth = new UsernamePasswordAuthenticationToken(email, null, Collections.emptyList());
            SecurityContextHolder.getContext().setAuthentication(auth);
            return true;

        } catch (Exception e) {
<<<<<<< HEAD
            e.printStackTrace();
            return false;
=======
            return false; //capturar a exception
>>>>>>> fbdedf1350f0c9c83374f9da4f92c75a72465ba2
        }
    }


    public Claims validarToken(String token) {
        try {
            return Jwts.parserBuilder()
                    .setSigningKey(Keys.hmacShaKeyFor(secretKey.getBytes()))
                    .build()
                    .parseClaimsJws(token)
                    .getBody();
        } catch (ExpiredJwtException e) {
            // Token expirado
            System.out.println("Token expirado em: " + e.getClaims().getExpiration());
            throw new InvalidObjectException("Token expirado");
        } catch (JwtException e) {
            throw new InvalidObjectException("Token inválido");
        }
    }
}



