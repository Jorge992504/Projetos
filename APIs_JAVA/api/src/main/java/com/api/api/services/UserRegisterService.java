package com.api.api.services;

import com.api.api.Dto.RegistroDto;
import com.api.api.models.Users;
import com.api.api.repositories.UserRepository;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.*;

@Service
public class UserRegisterService {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final JavaMailSender javaMailSender;


    @Value("${jwt.secret}")
    private String secreKey;
    @Value("${jwt.expiration}")
    private Long expirationTime;


    public UserRegisterService(UserRepository userRepository, JavaMailSender javaMailSender) {
        this.userRepository = userRepository;
        this.javaMailSender = javaMailSender;
        this.passwordEncoder = new BCryptPasswordEncoder();
    }

    public boolean verificaUser(String email) {
        Optional<Users> user = userRepository.findByEmail(email);
        return user.isPresent();
    }

    @Transactional
    public Users saveUser(RegistroDto body){
        String password = passwordEncoder.encode(body.password());
        Random random = new Random();
        int codigo = 1000 + random.nextInt(9000);
        Users user = Users.builder().name(body.name()).email(body.email()).password(password).verificado(false).codVerif(codigo).build();
        return userRepository.save(user);
    }

    public String geraToken(String email, String password) {
        String token;
        Optional<Users> user = userRepository.findByEmail(email);
        if (user.isPresent()) {
            String passwordBD = user.get().getPassword();
            if (passwordEncoder.matches(password, passwordBD)) {
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
            } else {
                return null;
            }

        } else {
            return null;
        }


    }

    public void enviarEmail(String destinatario, int codigo) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(destinatario);
        message.setSubject("Código de verificação");
        message.setText("Seu código de verificação é: " + codigo);
        javaMailSender.send(message);
    }


}
