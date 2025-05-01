package com.api.api.config;

import com.api.api.controller.authorization.AuthorizationFilter;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    private final AuthorizationFilter authorizationFilter;

    // Injeção do filtro de autorização no construtor
    public SecurityConfig(AuthorizationFilter authorizationFilter) {
        this.authorizationFilter = authorizationFilter;
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                .csrf(csrf -> csrf.disable())  // Desabilita CSRF
                .authorizeHttpRequests(authz -> authz
                        .requestMatchers("/login", "/register", "/controller/verificar").permitAll()  // Permite as rotas públicas
                        .anyRequest().authenticated());  // Desabilita o login padrão (formulário)

        // Adiciona o filtro de autorização antes do filtro de autenticação padrão
        http.addFilterBefore(authorizationFilter, UsernamePasswordAuthenticationFilter.class);

        return http.build();
    }
}
