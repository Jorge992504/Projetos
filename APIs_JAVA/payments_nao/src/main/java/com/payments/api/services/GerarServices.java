package com.payments.api.services;

import com.payments.api.customexception.CustomException;
import com.payments.api.models.Users;
import com.payments.api.repositorys.UserRepository;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@Service
public class GerarServices {

    private final UserRepository userRepository;

    @Value("${jwt.secretKey}")
    private String secretKey;
    @Value("${jwt.expirationToken}")
    private Long expirationTokenTime;

    public GerarServices(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public String gerarToken(String email){
        String token;
        Optional<Users> users = userRepository.findByEmail(email);
        if (users.isPresent()){
            Map<String, Object> claims = new HashMap<>();
            claims.put("id", users.get().getId());
            claims.put("email", users.get().getEmail());
            token = Jwts.builder().setClaims(claims)
                    .setIssuedAt(new Date(System.currentTimeMillis()))
                    .setExpiration(Date.from(LocalDateTime.now().plusDays(expirationTokenTime).atZone(ZoneId.systemDefault()).toInstant()))
                    .signWith(SignatureAlgorithm.HS256, secretKey)
                    .compact();
            return token;
        }else{
            throw new CustomException(201,"USER_NOT_PRESENT","Usuário não cadastrado");
        }
    }
}
