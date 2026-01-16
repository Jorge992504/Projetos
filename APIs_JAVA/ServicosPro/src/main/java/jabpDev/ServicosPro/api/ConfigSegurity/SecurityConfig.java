package jabpDev.ServicosPro.api.ConfigSegurity;

import com.fasterxml.jackson.databind.ObjectMapper;
import jabpDev.ServicosPro.api.Controllers.WebSocket.WebSocketController;
import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;


import java.io.IOException;

@Configuration
@AllArgsConstructor
@EnableWebSecurity
public class SecurityConfig {

    private final AuthorizationFilter authorizationFilter;
    private final FiltrosLiberados filtrosLiberados;

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity httpSecurity) throws IOException {
        httpSecurity.csrf(AbstractHttpConfigurer::disable)
                .authorizeHttpRequests(auth -> auth
                        .requestMatchers(filtrosLiberados.getLogin()).permitAll()
                        .requestMatchers(filtrosLiberados.getRegistrar()).permitAll()
                        .requestMatchers(filtrosLiberados.getRedefinirSenha()).permitAll()
                        .requestMatchers(filtrosLiberados.getReceberEmail()).permitAll()
                        .requestMatchers(filtrosLiberados.getValidarCodigo()).permitAll()
                        .requestMatchers(filtrosLiberados.getValidarConexao()).permitAll()
                        .anyRequest().authenticated()
                );
        httpSecurity.addFilterBefore(authorizationFilter, UsernamePasswordAuthenticationFilter.class);
        return httpSecurity.build();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
    @Bean
    public ObjectMapper objectMapper() {
        return new ObjectMapper();
    }
}
