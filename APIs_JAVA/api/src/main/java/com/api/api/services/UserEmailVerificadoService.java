package com.api.api.services;


import com.api.api.Dto.TokenResponseDto;
import com.api.api.exception.ErroException;
import com.api.api.models.Users;
import com.api.api.repositories.UserRepository;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.*;

@Service
public class UserEmailVerificadoService {

    private final UserRepository userRepository;
    private final JavaMailSender javaMailSender;

    public UserEmailVerificadoService(UserRepository userRepository, JavaMailSender javaMailSender) {
        this.userRepository = userRepository;
        this.javaMailSender = javaMailSender;
    }

    @Value("${jwt.secret}")
    private String secreKey;
    @Value("${jwt.expiration}")
    private Long expirationTime;

    private void enviarEmail(String destinatario, int codigo) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(destinatario);
        message.setSubject("Código de verificação");
        message.setText("Seu código de verificação é: " + codigo);
        javaMailSender.send(message);
    }

    public String atualizaVerificado(String email, int codigo) {
        if (email.isEmpty()) {
            throw new ErroException("Email não informado");
        }


        Optional<Users> user = userRepository.findByEmail(email);
        if (user.isPresent()) {
            Users response = user.get();
            response.setVerificado(true);
            userRepository.save(response);
            return geraToken(email);
        } else {
            throw new ErroException("Usuário não encontrado");
        }

    }


    public String geraToken(String email) {
        String token;
        Optional<Users> user = userRepository.findByEmail(email);
        if (user.isPresent()) {

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


    }

//    //A cada 5 minutos enviar um e-mail
//    @Scheduled(fixedDelay = 300000)
//    public void enviaCodigosParaUsuarios() {
//        List<Users> users = userRepository.findByVerificado(false);
//
//        for (Users user : users) {
//            if (!user.isVerificado()) {
//                enviarEmail(user.getEmail(), user.getCodVerif());
//            }
//        }
//
//    }

}
