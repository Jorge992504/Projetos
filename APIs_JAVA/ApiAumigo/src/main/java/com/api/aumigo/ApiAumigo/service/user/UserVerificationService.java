package com.api.aumigo.ApiAumigo.service.user;


import com.api.aumigo.ApiAumigo.models.Users;
import com.api.aumigo.ApiAumigo.repository.UserRepository;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.crypto.SecretKey;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.*;

@Service
public class UserVerificationService {
    private final UserRepository userRepository;

    public UserVerificationService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Value("${jwt.secretKey}")
    String secretKey;
    @Value("${jwt.expiration}")
    int expirationTime;
    String token;

    public String verificaEmail(String email, int codigo) {
        Optional<Users> user = userRepository.findByEmail(email);
        if (user.isPresent() && user.get().getCodigo() == codigo) {
            Users response = user.get();
            response.setVerificado(true);
            userRepository.save(response);
            token = geraToken(user.get().getEmail(), user.get().getId(), user.get().getName(), user.get().getTipo());
            if (token.isEmpty()) {
                return null;
            } else {
                return token;
            }
        } else {
            return null;
        }
    }

    public String geraToken(String email, Long id, String name, String tipo) {
        Optional<Users> user = userRepository.findByEmail(email);

        if (user.isPresent() && Boolean.TRUE.equals(user.get().getVerificado())) {
            Map<String, Object> claims = new HashMap<>();
            claims.put("id", id);
            claims.put("email", email);
            claims.put("name", name);

            Date expirationDate = Date.from(
                    LocalDateTime.now()
                            .plusDays(expirationTime)
                            .atZone(ZoneId.systemDefault())
                            .toInstant()
            );

            return Jwts.builder()
                    .setClaims(claims)
                    .setIssuedAt(new Date())
                    .setExpiration(expirationDate)
                    .signWith(Keys.hmacShaKeyFor(secretKey.getBytes()), SignatureAlgorithm.HS256)
                    .compact();
        } else {
            return null;
        }
    }
}
