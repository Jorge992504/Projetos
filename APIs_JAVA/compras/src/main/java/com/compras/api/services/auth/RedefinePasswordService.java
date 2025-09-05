package com.compras.api.services.auth;


import com.compras.api.api.exception.ErrorException;
import com.compras.api.api.models.Users;
import com.compras.api.api.repository.user.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@RequiredArgsConstructor
public class RedefinePasswordService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    public void redefinirSenha(String email, String Newpassword){
        Users users = userRepository.findByEmail(email).orElseThrow(() -> new ErrorException("Usuário não encontrado"));
        users.setPassword(passwordEncoder.encode(Newpassword));
        userRepository.save(users);
    }
}
