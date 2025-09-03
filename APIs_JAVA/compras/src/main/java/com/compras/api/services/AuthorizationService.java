package com.compras.api.services;


import com.compras.api.api.exception.ErrorException;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import io.jsonwebtoken.security.SignatureException;
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

    //verifica se o token é valido
    public boolean isAuthorized(HttpServletRequest request) throws IOException {
        String authHeader = request.getHeader("Authorization");

        if (authHeader == null || !authHeader.startsWith("Bearer ")) {
            throw new ErrorException("Authorization header ausente ou mal formatado");

        }

        String token = authHeader.replace("Bearer ", "");

        try {
            Claims claims = getClaimsFromToken(token);
            String user = claims.getSubject();

            if (user == null) {
                throw new ErrorException("Token sem subject (sub)");
            }

            var auth = new UsernamePasswordAuthenticationToken(user, null, Collections.emptyList());
            SecurityContextHolder.getContext().setAuthentication(auth);
            return true;
        } catch (Exception e) {
            throw new ErrorException("Erro ao validar token");
        }
    }
    public Claims getClaimsFromToken(String token) throws SignatureException {
        return Jwts.parserBuilder()
                .setSigningKey(Keys.hmacShaKeyFor(secretKey.getBytes()))
                .build()
                .parseClaimsJws(token)
                .getBody();
    }


    public Claims validarToken(String token) {
        try {
            return Jwts.parserBuilder()
                    .setSigningKey(Keys.hmacShaKeyFor(secretKey.getBytes()))
                    .build()
                    .parseClaimsJws(token)
                    .getBody();
        } catch (ExpiredJwtException e) {
            throw new ErrorException("InvalidObject");
        } catch (JwtException e) {
            throw new ErrorException("InternalError");
        }
    }
}
