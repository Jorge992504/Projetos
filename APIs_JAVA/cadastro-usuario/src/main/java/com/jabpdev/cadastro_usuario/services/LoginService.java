package com.jabpdev.cadastro_usuario.services;

import com.jabpdev.cadastro_usuario.dto.request.LoginRequest;
import com.jabpdev.cadastro_usuario.infra.entitys.Usuario;
import com.jabpdev.cadastro_usuario.infra.repositorys.UsuarioRepository;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.oauth2.jwt.JwtClaimsSet;
import org.springframework.security.oauth2.jwt.JwtEncoder;
import org.springframework.security.oauth2.jwt.JwtEncoderParameters;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@Service
@AllArgsConstructor
public class LoginService {


    private final UsuarioRepository usuarioRepository;
    private BCryptPasswordEncoder passwordEncoder;
    private Long getTimeExperation;
    private String getPrivateKeyString;






    public String login(LoginRequest loginRequest){
        Optional<Usuario> usuarioOptional = usuarioRepository.findByEmail(loginRequest.email());
        if (usuarioOptional.isEmpty()){
            throw new RuntimeException("Usuário não cadastrado");
        }else if (!passwordEncoder.matches(loginRequest.password(), usuarioOptional.get().getPassword())){
            throw new RuntimeException("Senha incorreta");
        }else{
            return gerarToken(usuarioOptional.get().getEmail(), usuarioOptional.get().getId());
        }
    }

    public String gerarToken(String email, Long id){
        Map<String, Object> claims = new HashMap<>();
        claims.put("id", id);
        claims.put("email", email);
        String accessToken = Jwts.builder()
                .setClaims(claims)
                .setSubject(email)
                .setIssuedAt(new Date(System.currentTimeMillis()))
                .setExpiration(Date.from(LocalDateTime.now().plusDays(getTimeExperation).atZone(ZoneId.systemDefault()).toInstant()))
                .signWith(Keys.hmacShaKeyFor(getPrivateKeyString.getBytes()), SignatureAlgorithm.HS256)
                .compact();
        return accessToken;
    }


}
