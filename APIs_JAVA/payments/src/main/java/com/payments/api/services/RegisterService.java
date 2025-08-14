package com.payments.api.services;


import com.payments.api.customexception.CustomException;
import com.payments.api.dto.request.RequestRegisterDto;
import com.payments.api.models.Users;
import com.payments.api.repositorys.UserRepository;
import jakarta.transaction.Transactional;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class RegisterService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    public RegisterService(UserRepository userRepository) {
        this.userRepository = userRepository;
        this.passwordEncoder = new BCryptPasswordEncoder();
    }

    @Transactional
    public Users saveUser(RequestRegisterDto body){
        Optional<Users> optionalUsers = userRepository.findByEmail(body.email());
        if (optionalUsers.isPresent()){
            throw new CustomException(201,"USER_PRESENT","Usuário já cadastrado");
        }else{
            String password = passwordEncoder.encode(body.password());
            Users users = Users.builder().email(body.email()).name(body.name()).password(password).build();
            return userRepository.save(users);
        }
    }
}
