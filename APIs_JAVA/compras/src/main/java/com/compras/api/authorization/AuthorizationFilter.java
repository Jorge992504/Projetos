package com.compras.api.authorization;


import com.compras.api.services.AuthorizationService;
import io.jsonwebtoken.Claims;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

@Component
public class AuthorizationFilter extends OncePerRequestFilter {
    private final AuthorizationService authorizationService;

    public AuthorizationFilter(AuthorizationService authorizationService){
        this.authorizationService =authorizationService;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        String path = request.getServletPath();

        if (path.equals("/register") || path.equals("/login") || path.startsWith("/public/")) {
            filterChain.doFilter(request, response);
            return;
        }
        if (!authorizationService.isAuthorized(request)) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED); // 401
            return;
        }

        String header = request.getHeader("Authorization");

        if (header != null && header.startsWith("Bearer ")) {
            String token = header.substring(7);
            try {
                Claims claims =authorizationService.validarToken(token);
                String email = claims.get("email", String.class);
                // Crie a autenticação aqui se quiser continuar com Spring Security
            } catch (RuntimeException e) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                response.getWriter().write("Token inválido ou expirado: " + e.getMessage());
                return;
            }
        }
        filterChain.doFilter(request, response);
    }
}
