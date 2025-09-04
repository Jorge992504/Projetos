package com.compras.api.services.auth;

import com.compras.api.api.dto.request.RequestRegisterUserDto;
import com.compras.api.api.models.Users;
import com.compras.api.api.repository.user.UserRepository;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import io.jsonwebtoken.Jwts;

import java.sql.Date;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.*;

@Service
public class ServiceRegisterUser {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    @Value("${jwt.secret}")
    private String secretKey;
    @Value("${jwt.expiration}")
    private Long expirationTokenTime;

    public ServiceRegisterUser(UserRepository userRepository, JavaMailSender javaMailSender) {
        this.userRepository = userRepository;
        this.passwordEncoder = new BCryptPasswordEncoder();
    }

    public boolean verificaUser(String email) {
        Optional<Users> user = userRepository.findByEmail(email);
        return user.isPresent();
    }

    @Transactional
    public Users saveUser(RequestRegisterUserDto body){
        String password = passwordEncoder.encode(body.password());
        Random random = new Random();
        Users user = Users.builder().name(body.
                name()).email(body.email()).password(password).build();
        return userRepository.save(user);
    }

    public String gerarToken(String email) {
        String token;
        Optional<Users> user = userRepository.findByEmail(email);
        if (user.isPresent()) {
                Map<String, Object> claims = new HashMap<>();
                claims.put("id", user.get().getId());
                claims.put("email", user.get().getEmail());
                token = Jwts.builder().setClaims(claims)
                        .setIssuedAt(new Date(System.currentTimeMillis()))
                        .setExpiration(Date.from(LocalDateTime.now().plusDays(expirationTokenTime).atZone(ZoneId.systemDefault()).toInstant()))
                        .signWith(Keys.hmacShaKeyFor(secretKey.getBytes()), SignatureAlgorithm.HS256)
                        .compact();
                return token;
        } else {
            return null;
        }
    }


}
