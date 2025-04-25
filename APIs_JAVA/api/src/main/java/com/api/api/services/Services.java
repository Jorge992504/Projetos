package com.api.api.services;

import com.api.api.Dto.RegistroDto;
import com.api.api.models.Users;
import com.api.api.repositories.UserRepository;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class Services {
    private final UserRepository userRepository;

    public Services(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public boolean verificaUser(String email) {
        Optional<Users> user = userRepository.findByEmail(email);
        return user.isPresent();
    }

    @Transactional
    public Users saveUser(RegistroDto body) {
        Users user = Users.builder().name(body.name()).email(body.email()).password(body.password()).build();
        return userRepository.save(user);
    }
}
