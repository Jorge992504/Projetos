package com.compras.api.services.auth;


import com.compras.api.api.dto.response.ResponseLoginUserDto;
import com.compras.api.api.models.Users;
import com.compras.api.api.repository.user.UserRepository;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;
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
public class ServiceLoginUser {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    public ServiceLoginUser(UserRepository userRepository){
        this.userRepository = userRepository;
        this.passwordEncoder = new BCryptPasswordEncoder();
    }

    @Value("${jwt.secret}")
    private String secretKey;
    @Value("${jwt.expiration}")
    private Long expirationTokenTime;

    public String loginUser(ResponseLoginUserDto loginUserDto){
        String token;
        Optional<Users> user = userRepository.findByEmail(loginUserDto.email());
        if (user.isPresent()){
            String newPassword = user.get().getPassword();
            if (passwordEncoder.matches(loginUserDto.password(),newPassword)){
                Map<String, Object> claims = new HashMap<>();
                claims.put("id", user.get().getId());
                claims.put("email", user.get().getEmail());
                token = Jwts.builder()
                        .setClaims(claims)
                        .setSubject(user.get().getEmail())
                        .setIssuedAt(new Date(System.currentTimeMillis()))
                        .setExpiration(Date.from(LocalDateTime.now().plusDays(expirationTokenTime).atZone(ZoneId.systemDefault()).toInstant()))
                        .signWith(Keys.hmacShaKeyFor(secretKey.getBytes()), SignatureAlgorithm.HS256)
                        .compact();
                return token;
            }else{
                return null;
            }
        }else{
            return null;
        }
    }
}
