package com.compras.api.services;


import com.compras.api.api.exception.ErrorException;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.SignatureException;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
public class AuthorizationService {

    @Value("${jwt.secret}")
    private String secretKey;

    //verifica se o token é valido
    public boolean isAuthorized(HttpServletRequest request) {
        String authHeader = request.getHeader("Authorization");
        if (authHeader == null || !authHeader.startsWith("Bearer ")) {
            return false;
        }
        String token = authHeader.replace("Bearer ", "");

        try {
            Claims claims = getClaimsFromToken(token);
            String user = claims.getSubject();
            return user != null && !user.isEmpty();
        } catch (Exception e) {
            return false;
        }
    }
    public Claims getClaimsFromToken(String token) throws SignatureException {
        return Jwts.parser().setSigningKey(secretKey.getBytes())
                .parseClaimsJws(token)
                .getBody();
    }
}
