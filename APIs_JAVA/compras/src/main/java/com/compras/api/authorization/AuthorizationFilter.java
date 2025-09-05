package com.compras.api.authorization;


import com.compras.api.api.exception.AuthorizationException;
import com.compras.api.api.exception.ErrorException;
import com.compras.api.services.AuthorizationService;
import com.compras.api.services.user.ServiceUser;
import io.jsonwebtoken.Claims;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.http.HttpStatus;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

@Component
public class AuthorizationFilter extends OncePerRequestFilter {
    private final AuthorizationService authorizationService;
    private final ServiceUser serviceUser;

    public AuthorizationFilter(AuthorizationService authorizationService, ServiceUser serviceUser) {
        this.authorizationService = authorizationService;
        this.serviceUser = serviceUser;
    }

    @Override
    protected void doFilterInternal(
            HttpServletRequest request,
            HttpServletResponse response,
            FilterChain filterChain) throws ServletException, IOException {

        String path = request.getServletPath();

        if (path.equals("/register") || path.equals("/login") || path.startsWith("/redefine") || path.startsWith("/public")) {
            filterChain.doFilter(request, response);
            return;
        }

        String header = request.getHeader("Authorization");

        if (header == null || !header.startsWith("Bearer ")) {
            writeErrorResponse(response, "Token não informado");
            return; // não segue no filterChain
        }

        String token = header.substring(7);

        try {
            Claims claims = authorizationService.validarToken(token);
            String email = claims.get("email", String.class);

            var userDetail = serviceUser.getUser(email)
                    .orElseThrow(() -> new AuthorizationException("Usuário não encontrado"));

            UsernamePasswordAuthenticationToken authToken =
                    new UsernamePasswordAuthenticationToken(
                            userDetail,
                            null,
                            userDetail.getAuthorities()
                    );

            authToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
            SecurityContextHolder.getContext().setAuthentication(authToken);

            // segue para o próximo filtro só se deu certo
            filterChain.doFilter(request, response);

        } catch (AuthorizationException e) {
            writeErrorResponse(response, e.getMessage());
        }
    }

    private void writeErrorResponse(HttpServletResponse response, String message) throws IOException {
        response.setStatus(HttpStatus.UNAUTHORIZED.value());
        response.setContentType("application/json");
        response.getWriter().write(
                String.format("{\"message\": \"%s\"}", message)
        );
    }
}
