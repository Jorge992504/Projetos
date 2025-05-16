package com.api.aumigo.ApiAumigo.config;


import com.api.aumigo.ApiAumigo.authorization.AuthorizationFilter;
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
        this.authorizationFilter = authorizationFilter;
    }


    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity httpSecurity) throws Exception{
        httpSecurity
                .csrf(AbstractHttpConfigurer::disable)
                .authorizeHttpRequests(auth -> auth
                        .requestMatchers(PublicRoutes.path).permitAll()
                        .anyRequest().authenticated());
        httpSecurity.addFilterBefore(authorizationFilter, UsernamePasswordAuthenticationFilter.class);
        return httpSecurity.build();
    }

    public class PublicRoutes {
        public static final String[] path = { "/registeruser", "/loginuser", "/verificaEmail","/chatPv" };
    }
}
