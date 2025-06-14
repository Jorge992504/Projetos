package com.compras.api.api.config;


import com.compras.api.authorization.AuthorizationFilter;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration

public class SecurityConfig {
    private final AuthorizationFilter authorizationFilter;

    public SecurityConfig(AuthorizationFilter authorizationFilter){
        this.authorizationFilter =authorizationFilter;
    }
    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                .csrf(AbstractHttpConfigurer::disable)  // Desabilita CSRF
                .authorizeHttpRequests(authz -> authz
                        .requestMatchers("/login", "/register").permitAll()  // Permite as rotas públicas
                        .anyRequest().authenticated());  // Desabilita o login padrão (formulário)

        // Adiciona o filtro de autorização antes do filtro de autenticação padrão
        http.addFilterBefore(authorizationFilter, UsernamePasswordAuthenticationFilter.class);

        return http.build();
    }
}
