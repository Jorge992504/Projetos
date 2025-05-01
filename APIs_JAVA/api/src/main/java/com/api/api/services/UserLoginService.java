package com.api.api.services;


import com.api.api.Dto.LoginDto;
import com.api.api.exception.ErroException;
import com.api.api.models.Users;
import com.api.api.repositories.UserRepository;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@Service
public class UserLoginService {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;


    public UserLoginService(UserRepository userRepository){
        this.userRepository = userRepository;
        this.passwordEncoder = new BCryptPasswordEncoder();
    }

    @Value("${jwt.secret}")
    private String secreKey;
    @Value("${jwt.expiration}")
    private Long expirationTime;

    public String login(LoginDto param){
        String token;
        Optional<Users> user = userRepository.findByEmail(param.email());
        if (user.isPresent()) {
            if (user.get().isVerificado()){
                String passwordBD = user.get().getPassword();
                if (passwordEncoder.matches(param.password(), passwordBD)) {
                    Map<String, Object> claims = new HashMap<>();
                    claims.put("id", user.get().getId());
                    claims.put("email", user.get().getEmail());
                    token = Jwts.builder().setClaims(claims)
                            .setIssuedAt(new Date(System.currentTimeMillis()))
                            .setExpiration(Date.from(LocalDateTime.now().plusDays(expirationTime)
                                    .atZone(ZoneId.systemDefault())
                                    .toInstant()))
                            .signWith(SignatureAlgorithm.HS256, secreKey)
                            .compact();
                    return token;
                }else{
                    return null;
                }
            }else{
                throw new ErroException("Usuário não verificado");
            }

        } else {
            return null;
        }
    }

}
