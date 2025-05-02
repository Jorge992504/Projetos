package com.api.api.services.authorization;


import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
public class AuthorizationService {

    @Value("${jwt.secret}")
    private String secreKey;

    public boolean isToken(String token) {
        Claims claims = parseToken(token);
        if (claims.getSubject() != null && !claims.getSubject().isEmpty()) {
            return true;
        } else {
            return false;
        }
    }


    private Claims parseToken(String token) {
        return Jwts.parser()
                .setSigningKey(secreKey.getBytes())
                .parseClaimsJws(token.replace("Bearer ", ""))
                .getBody();
    }

    public String getUsernameFromToken(String token){
        Claims claims = parseToken(token);
        return claims.getSubject();
    }
}
