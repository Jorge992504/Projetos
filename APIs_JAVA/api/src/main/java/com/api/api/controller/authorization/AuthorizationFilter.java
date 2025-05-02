package com.api.api.controller.authorization;

import com.api.api.services.authorization.AuthorizationService;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

@Component
public class AuthorizationFilter extends OncePerRequestFilter {

    private final AuthorizationService authorizationService;

    public AuthorizationFilter(AuthorizationService authorizationService) {
        this.authorizationService = authorizationService;
    }

    @Override
<<<<<<< HEAD
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws SecurityException, IOException, ServletException {


        final String authHeader = request.getHeader("Authorization");

        if (authHeader == null || !authHeader.startsWith("Bearer ")){
=======
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {

        String path = request.getServletPath();

        // Ignora rotas públicas
        if (path.equals("/register") || path.equals("/login") || path.equals("/controller/verificar")) {
>>>>>>> 7f526ffc1b88b7fab140e11c7dc8f1684afa4027
            filterChain.doFilter(request, response);
            return;
        }

<<<<<<< HEAD
        String token = authHeader.substring(7);
        if (authorizationService.isToken(token)) {
            String username = authorizationService.getUsernameFromToken(token);

            // Aqui você pode criar uma autenticação básica
            UsernamePasswordAuthenticationTokennToken auth =
                    new UsernamePasswordAuthenticationToken(username, null, null);
            auth.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));

            SecurityContextHolder.getContext().setAuthentication(auth);
        }

        filterChain.doFilter(request, response);
    }
=======
        // Verifica autorização JWT
        if (!authorizationService.isAuthorized(request)) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED); // 401
            return;
        }

        filterChain.doFilter(request, response);
>>>>>>> 7f526ffc1b88b7fab140e11c7dc8f1684afa4027
    }
}
