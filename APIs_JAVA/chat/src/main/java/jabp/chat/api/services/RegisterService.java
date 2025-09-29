package jabp.chat.api.services;

import jabp.chat.api.dto.request.RegisterDtoRequest;
import jabp.chat.api.entitys.Usuario;
import jabp.chat.api.repositorio.UsuarioRepository;
import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@AllArgsConstructor
public class RegisterService {
    private final UsuarioRepository usuarioRepository;
    private final UsuarioService usuarioService;
    private final PasswordEncoder passwordEncoder;


    @Transactional
    public String register(RegisterDtoRequest registerBody) {
        // Lógica de registro de usuário
        // Verificar se o usuário já existe
        if (usuarioService.buscaUsuario(registerBody.email()).isPresent()) {
            throw new RuntimeException("Usuário já existe");
        }
        if (registerBody.email().isEmpty() || registerBody.password().isEmpty() || registerBody.name().isEmpty()) {
            throw new RuntimeException("Dados incompletos");
        }
        // Criar e salvar o novo usuário
        String passwordHash = passwordEncoder.encode(registerBody.password());
        Usuario usuario = Usuario.builder()
                .email(registerBody.email())
                .password(passwordHash)
                .name(registerBody.name())
                .build();
        usuarioRepository.save(usuario);

        // Gerar token para o novo usuário
        return usuarioService.gerarToken(registerBody.email(), usuario.getId());
    }
}
