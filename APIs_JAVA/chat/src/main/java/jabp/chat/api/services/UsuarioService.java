package jabp.chat.api.services;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;
import jabp.chat.api.dto.response.HistoricoMessagesDtoResponse;
import jabp.chat.api.entitys.Message;
import jabp.chat.api.entitys.Usuario;
import jabp.chat.api.exceptions.AuthorizationException;
import jabp.chat.api.exceptions.ErrorException;
import jabp.chat.api.repositorio.HistoricoMessageRepository;
import jabp.chat.api.repositorio.UsuarioRepository;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class UsuarioService {

    private final UsuarioRepository usuarioRepository;
    private final HistoricoMessageRepository messageRepository;


    @Value("${jwt.secret}")
    private String secretKey;
    @Value("${jwt.expiration}")
    private Long expirationTime;

    public UsuarioService(UsuarioRepository usuarioRepository, HistoricoMessageRepository messageRepository) {
        this.usuarioRepository = usuarioRepository;
        this.messageRepository = messageRepository;
    }


    public Optional<Usuario> buscaUsuario(String email){
        if (email.isEmpty()){
            throw new ErrorException("O e-mail não é valido");
        }else{
            return usuarioRepository.findByEmail(email);
        }
    }

    public String gerarToken(String email, Long id){
        Map<String, Object> claims = new HashMap<>();
        claims.put("id", id);
        claims.put("email", email);
       return  Jwts.builder()
                .setClaims(claims)
                .setSubject(email)
                .setIssuedAt(new Date(System.currentTimeMillis()))
                .setExpiration(Date.from(LocalDateTime.now().plusDays(expirationTime).atZone(ZoneId.systemDefault()).toInstant()))
                .signWith(Keys.hmacShaKeyFor(secretKey.getBytes()), SignatureAlgorithm.HS256)
                .compact();
    }


    public boolean validarToken(String token) {
        try {
            Claims claims = Jwts.parserBuilder()
                    .setSigningKey(Keys.hmacShaKeyFor(secretKey.getBytes()))
                    .build()
                    .parseClaimsJws(token)
                    .getBody();

            String email = claims.getSubject();
            if (email == null || email.isEmpty()) {
                throw new AuthorizationException("Token inválido: email ausente");
            }
            Optional<Usuario> usuarioOpt = buscaUsuario(email);
            if (usuarioOpt.isEmpty()) {
                throw new AuthorizationException("Usuário não encontrado para o email no token");
            }
            return true;

        } catch (Exception e) {
            throw new AuthorizationException("Token inválido ou expirado");
        }
    }
}
