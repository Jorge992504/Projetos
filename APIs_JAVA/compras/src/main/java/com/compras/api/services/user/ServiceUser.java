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


    public ServiceUser(UserRepository userRepository){
        this.userRepository = userRepository;
    }

    public Optional<Users> getUser(String email){
        return userRepository.findByEmail(email);
    }

}
