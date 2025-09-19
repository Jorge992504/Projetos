package jabp.chat.api.services;


import jabp.chat.api.entitys.Usuario;
import jabp.chat.api.exceptions.ErrorException;
import jabp.chat.api.repositorio.UsuarioRepository;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@AllArgsConstructor
public class LoginService {

    private final UsuarioRepository usuarioRepository;
    private final PasswordEncoder passwordEncoder;
    private final UsuarioService usuarioService;


    public String login(String email, String password){
        Optional<Usuario> usuario = usuarioRepository.findByEmail(email);
        if (usuario.isPresent()){
            String newPassword = usuario.get().getPassword();
            if (passwordEncoder.matches(password,newPassword)){
                return usuarioService.gerarToken(email,usuario.get().getId());
            }else{
                throw new ErrorException("Senha incorreta");
            }
        }else {
            throw new ErrorException("Usuário não encontrado");
        }
    }
}
