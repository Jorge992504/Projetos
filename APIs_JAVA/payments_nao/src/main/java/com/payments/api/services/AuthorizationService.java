package com.payments.api.services;


import com.payments.api.customexception.CustomException;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;

import java.util.Collections;

@Service
public class AuthorizationService {

    @Value("${jwt.secretKey}")
    private String secretKey;

    public boolean isAuthorized(HttpServletRequest httpServletRequest){
        String authHeader = httpServletRequest.getHeader("Authorization");
        if(authHeader == null || !authHeader.startsWith("Bearer ")){
            throw new CustomException(400,"MISSING_HEADER","Header ausente");
        }
        String token = authHeader.replace("Bearer ", "");
        try {
            Claims claims = getClaimsFromToken(token);
            String user = claims.getSubject();
            if (user == null){
                throw new CustomException(401, "TOKEN_EMPTY","O token não contem o usuário");
            }
            var auth = new UsernamePasswordAuthenticationToken(user,null, Collections.emptyList());
            SecurityContextHolder.getContext().setAuthentication(auth);
            return true;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public Claims getClaimsFromToken(String token){
        try{
            return Jwts.parserBuilder()
                    .setSigningKey(Keys.hmacShaKeyFor(secretKey.getBytes()))
                    .build()
                    .parseClaimsJws(token)
                    .getBody();
        }catch (ExpiredJwtException expiredJwtException){
            throw new CustomException(401,"JWT_EXPIRED",expiredJwtException.getMessage());
        }catch (JwtException jwtException){
            throw new CustomException(401,"JWT_ERROR",jwtException.getMessage());
        }
    }


    public Claims validarToken(String token){
        try {
            return Jwts.parserBuilder()
                    .setSigningKey(Keys.hmacShaKeyFor(secretKey.getBytes()))
                    .build()
                    .parseClaimsJws(token)
                    .getBody();
        }catch (ExpiredJwtException expiredJwtException){
            throw new CustomException(401,"JWT_EXPIRED",expiredJwtException.getMessage());
        }catch (JwtException jwtException) {
            throw new CustomException(401, "JWT_ERROR", jwtException.getMessage());
        }
    }

}
