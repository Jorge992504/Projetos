package com.api.aumigo.ApiAumigo.service;


import com.api.aumigo.ApiAumigo.dto.RegisterDto;
import com.api.aumigo.ApiAumigo.models.Users;
import com.api.aumigo.ApiAumigo.repository.UserRepository;
import jakarta.transaction.Transactional;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Optional;
import java.util.Random;

@Service
public class UserRegisterService {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;


    public UserRegisterService(UserRepository userRepository){
        this.userRepository = userRepository;
        this.passwordEncoder = new BCryptPasswordEncoder();
    }

    public boolean verificaUser(String email){
        Optional<Users> user = userRepository.findByEmail(email);
        return  user.isPresent();
    }

    @Transactional
    public Users saveUser(RegisterDto body){
        String password = passwordEncoder.encode(body.password());
        Random random = new Random();
        int codigo = 1000 + random.nextInt(9000);
        Users user = Users.builder()
                .name(body.name())
                .email(body.email())
                .password(password)
                .telefone(body.telefone())
                .tipo(body.tipo())
                .codigo(codigo)
                .data(body.date())
                .verificado(false)
                .build();
       return userRepository.save(user);
    }

}
