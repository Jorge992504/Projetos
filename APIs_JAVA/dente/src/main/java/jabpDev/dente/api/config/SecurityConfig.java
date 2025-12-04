package jabpDev.dente.api.config;


import jabpDev.dente.api.services.ExceptionService;
import lombok.AllArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@AllArgsConstructor
@EnableWebSecurity
public class SecurityConfig {

    private final AuthorizationFilter authorizationFilter;
    private final Filter filter;

//    @Value("${jwt.secret}")
//    private String secretKey;
//    @Value("${jwt.expiration}")
//    private Long expirationTokenTime;


    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity httpSecurity)throws Exception{
        httpSecurity.csrf(AbstractHttpConfigurer::disable)
                .authorizeHttpRequests(auth -> auth
                        .requestMatchers("/public/**").permitAll()
//                      .requestMatchers("/api/public/**").permitAll()
                        .requestMatchers(filter.getLogin()).permitAll()
                        .requestMatchers("/registrar/empresa").permitAll()
                        .requestMatchers( "/redefine/**").permitAll()
                        .requestMatchers(filter.getCard(), filter.getCardStatus()).permitAll()
                        .requestMatchers(filter.getPix(), filter.getPixStatus()).permitAll()
                        .requestMatchers(filter.getCardPublicKey()).permitAll()
                        .requestMatchers(filter.getPrecoFind()).permitAll()
                        .anyRequest().authenticated()
                )
                .formLogin(AbstractHttpConfigurer::disable)
                .httpBasic(AbstractHttpConfigurer::disable)
                ;

        httpSecurity.addFilterBefore(authorizationFilter, UsernamePasswordAuthenticationFilter.class);
        return httpSecurity.build();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();

    }

    @Bean
    public ExceptionService exceptionService(){
        return new ExceptionService();
    }

}
