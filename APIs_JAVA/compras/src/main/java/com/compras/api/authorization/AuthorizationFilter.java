package com.compras.api.authorization;


import com.compras.api.services.AuthorizationService;
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

        if (path.equals("/register") || path.equals("/login") || path.equals("/controller/verificar")) {
            filterChain.doFilter(request, response);
            return;
        }
        if (!authorizationService.isAuthorized(request)) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED); // 401
            return;
        }
        filterChain.doFilter(request, response);
    }
}
