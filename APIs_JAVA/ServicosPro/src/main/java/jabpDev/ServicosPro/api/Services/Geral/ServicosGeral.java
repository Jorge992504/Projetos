package jabpDev.ServicosPro.api.Services.Geral;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;
import jabpDev.ServicosPro.api.Dto.Request.RequestCategorias;
import jabpDev.ServicosPro.api.Dto.Response.ResponseCategorias;
import jabpDev.ServicosPro.api.Entitys.Categorias;
import jabpDev.ServicosPro.api.Entitys.Usuario;
import jabpDev.ServicosPro.api.Exceptions.CustomExeception.CustomException;
import jabpDev.ServicosPro.api.Exceptions.CustomExeception.TokenInvalidoException;
import jabpDev.ServicosPro.api.Repositorys.RepositoryCategorias;
import jabpDev.ServicosPro.api.Repositorys.RepositoryUsuario;
import jakarta.servlet.http.HttpServletResponse;
import lombok.Getter;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.*;

@Service
public class ServicosGeral {

    @Getter
    @Value("${jwt.secret}")
    private String secretKey;
    @Getter
    @Value("${jwt.expiration}")
    private Long timeExpirationToken;
    @Getter
    @Value("${app.base-url}")
    private String urlInterna;

    private final RepositoryUsuario repositoryUsuario;

    public ServicosGeral(RepositoryUsuario repositoryUsuario,RepositoryCategorias repositoryCategorias){
        this.repositoryUsuario = repositoryUsuario;
    }


    public Claims validarTokenRequesicao(String token, HttpServletResponse response){
        try{
            return Jwts.parserBuilder()
                    .setSigningKey(Keys.hmacShaKeyFor(secretKey.getBytes()))
                    .build()
                    .parseClaimsJws(token)
                    .getBody();
        }catch (TokenInvalidoException e){
            return  Jwts.claims();
        }
    }

    public String gerarToken(String email){
        Map<String,Object> claims = new HashMap<>();
        claims.put("email",email);
        return Jwts.builder().setClaims(claims)
                .setIssuedAt(new Date(System.currentTimeMillis()))
                .setExpiration(Date.from(LocalDateTime.now().plusDays(timeExpirationToken).atZone(ZoneId.systemDefault()).toInstant()))
                .signWith(Keys.hmacShaKeyFor(secretKey.getBytes()), SignatureAlgorithm.HS256)
                .compact();
    }

    public Usuario getUsuario(){
        String email =  SecurityContextHolder.getContext().getAuthentication().getName();
        System.out.println("Email: "+email);
        Optional<Usuario> usuario = repositoryUsuario.findByEmail(email);
        if (usuario.isEmpty()){
            throw new CustomException("Usuário sem permissão");
        }
        return usuario.get();
    }
}
