package com.api.aumigo.ApiAumigo.authorization;


import com.api.aumigo.ApiAumigo.service.authorization.AuthorizationService;
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
        this.authorizationService = authorizationService;
    }

    public String path;



    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        path = request.getServletPath();

        if (path.equals("/registeruser") || path.equals("/loginuser") || path.equals("/verificaEmail") || path.equals("/chatPv")){
            filterChain.doFilter(request,response);
            return;
        }

        if (!authorizationService.isAuthorized(request)){
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        filterChain.doFilter(request,response);
    }
}
