package com.payments.api.services;


import com.payments.api.models.Users;
import com.payments.api.repositorys.UserRepository;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class UserService {
    private final UserRepository userRepository;

    public UserService(UserRepository userRepository){
        this.userRepository = userRepository;
    }

    public Optional<Users> findUserByEmail(String email){
        return userRepository.findByEmail(email);
    }
}
