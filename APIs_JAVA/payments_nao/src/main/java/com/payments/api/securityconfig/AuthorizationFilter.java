package com.payments.api.securityconfig;


import com.payments.api.customexception.CustomException;
import com.payments.api.services.AuthorizationService;
import com.payments.api.services.UserService;
import io.jsonwebtoken.Claims;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
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
    private final UserService userService;

    public AuthorizationFilter(AuthorizationService authorizationService, UserService userService){
        this.authorizationService = authorizationService;
        this.userService = userService;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        String path = request.getServletPath();
        if (path.equals("/login") || path.equals("/nfe") || path.equals("/register") || path.equals("/public")){
            filterChain.doFilter(request,response);
            return;
        }
        if (!authorizationService.isAuthorized(request)){
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }
        String header = request.getHeader("Authorization");
        if (header != null && header.startsWith("Bearer ")){
            String token = header.substring(7);
            try {
                Claims claims = authorizationService.validarToken(token);
                String email = claims.get("email", String.class);
                UserDetails userDetails = userService.findUserByEmail(email).orElse(null);
                assert userDetails != null;
                UsernamePasswordAuthenticationToken authenticationToken =
                        new UsernamePasswordAuthenticationToken(
                                userDetails,
                                null,
                                userDetails.getAuthorities()
                        );
                authenticationToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
                SecurityContextHolder.getContext().setAuthentication(authenticationToken);
            } catch (RuntimeException e) {
                throw new CustomException(401,"SC_UNAUTHORIZED",e.getMessage());
            }
        }
        filterChain.doFilter(request,response);
    }


}
