package com.compras.api.services.user;


import com.compras.api.api.exception.ErrorException;
import com.compras.api.api.models.Users;
import com.compras.api.api.repository.user.UserRepository;
import com.compras.api.services.AuthorizationService;
import io.jsonwebtoken.Claims;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class ServiceUser {

    private final UserRepository userRepository;
    private final AuthorizationService authorizationService;


    public ServiceUser(UserRepository userRepository, AuthorizationService authorizationService){
        this.userRepository = userRepository;
        this.authorizationService = authorizationService;
    }

    public Optional<Users> getUser(HttpServletRequest request){
        boolean isAuthorized = authorizationService.isAuthorized(request);

        if (isAuthorized){
            String authHeader = request.getHeader("Authorization");
            if (authHeader == null || !authHeader.startsWith("Bearer ")){
                throw new ErrorException("Usuário não logado",501,"UNAUTHORAZED");
            }else{
                String token = authHeader.substring(7);
                Claims claims = authorizationService.getClaimsFromToken(token);
                String email = claims.getSubject();
                if (email.isEmpty()){
                    throw new ErrorException("Usuário não informado",401,"OBJECT_ISEMPTY");
                }else{
                    Optional<Users> user = userRepository.findByEmail(email);
                    if (user.isPresent()){
                        return user;
                    }else{
                        throw new ErrorException("Usuário não encontrado",401,"OBJECT_ISEMPTY");
                    }
                }
            }

        }else{
            throw new ErrorException("Usuário não encontrado",401,"OBJECT_ISEMPTY");
        }
    }

}
