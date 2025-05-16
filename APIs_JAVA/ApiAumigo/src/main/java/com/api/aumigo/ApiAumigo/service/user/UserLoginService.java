package com.api.aumigo.ApiAumigo.service.user;


import com.api.aumigo.ApiAumigo.models.Users;
import com.api.aumigo.ApiAumigo.repository.UserRepository;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class UserLoginService {
    private final UserRepository userRepository;
    private final UserVerificationService userVerificationService;
    private final PasswordEncoder passwordEncoder;

    String token;

    public UserLoginService(UserRepository userRepository, UserVerificationService userVerificationService) {
        this.userRepository = userRepository;
        this.userVerificationService = userVerificationService;
        this.passwordEncoder = new BCryptPasswordEncoder();
    }


    public String login(String email, String password) {
        Optional<Users> user = userRepository.findByEmail(email);
        if (user.isPresent()) {
            String passwordBD = user.get().getPassword();
            if (passwordEncoder.matches(password, passwordBD)) {
                token = userVerificationService.geraToken(user.get().getEmail(), user.get().getId(), user.get().getName(), user.get().getTipo());
                if (token.isEmpty()) {
                    return null;
                } else {
                    return token;
                }
            } else {
                return null;
            }
        } else {
            return null;
        }
    }
}
