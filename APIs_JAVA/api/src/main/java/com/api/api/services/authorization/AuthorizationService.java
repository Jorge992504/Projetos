package com.api.api.services.authorization;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureException;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.socket.WebSocketSession;

@Service
public class AuthorizationService {

    @Value("${jwt.secret}")
    private String secreKey;


    // Verifica se o token é válido
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


    // Extrai os claims do token
    public Claims getClaimsFromToken(String token) throws SignatureException {
        return Jwts.parser()
                .setSigningKey(secreKey.getBytes())
                .parseClaimsJws(token)
                .getBody();
    }

    // Obtém o "subject" (geralmente o ID ou nome de usuário principal)
    public String getUsernameFromRequest(HttpServletRequest request) {
        String token = extractToken(request);
        if (token == null) return null;

        try {
            return getClaimsFromToken(token).getSubject();
        } catch (Exception e) {
            return null;
        }
    }

    // 🔹 NOVO: Extrai o e-mail diretamente do token
    public String getEmailFromToken(String token) {
        try {
            Claims claims = getClaimsFromToken(token);
            return claims.get("email", String.class); // Usa claim "email"
        } catch (Exception e) {
            return null;
        }
    }

    // 🔹 NOVO: Extrai o e-mail a partir do HttpServletRequest
    public String getEmailFromRequest(HttpServletRequest request) {
        String token = extractToken(request);
        return getEmailFromToken(token);
    }

    // 🔹 Método utilitário para extrair o token do cabeçalho Authorization
    private String extractToken(HttpServletRequest request) {
        String authHeader = request.getHeader("Authorization");
        if (authHeader != null && authHeader.startsWith("Bearer ")) {
            return authHeader.replace("Bearer ", "");
        }
        return null;
    }

    public String getEmailFromSession(WebSocketSession session) {
        try {
            String token = session.getHandshakeHeaders().getFirst("Authorization");
            if (token != null && token.startsWith("Bearer ")) {
                token = token.replace("Bearer ", "");
                return getClaimsFromToken(token).get("email", String.class); // pega o e-mail do JWT
            }
        } catch (Exception ignored) {}
        return null;
    }
}
