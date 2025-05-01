package com.api.api.config;


import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public SecurityFilterChain securityFilterChain (HttpSecurity http) throws Exception{
        http
                .csrf(csrf -> csrf.disable())  // Desabilita CSRF (sem usar csrf() diretamente)
                .authorizeHttpRequests(authz -> authz
                        .requestMatchers("/login","/register","/contrller/verificar").permitAll()
                        .anyRequest().authenticated());  // Para outras rotas, requer autenticação
        return http.build();
    }
}
//.requestMatchers("/login").permitAll() //libera so essa rota
//.requestMatchers(HttpMethod.GET ,"/produto").permitAll() // libera so as requisições get para essa rota
//.requestMatchers("/registro").authenticated() // pede autorização para essa rota
//requestMatchers("/**").permitAll()  // Permite todas as rotas