package jabpDev.ServicosPro.api.Services.Auth;

import jabpDev.ServicosPro.api.Dto.Response.ResponseToken;
import jabpDev.ServicosPro.api.Entitys.Usuario;
import jabpDev.ServicosPro.api.Exceptions.CustomExeception.CustomException;
import jabpDev.ServicosPro.api.Repositorys.RepositoryUsuario;
import jabpDev.ServicosPro.api.Services.Geral.ServicosGeral;
import lombok.AllArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@AllArgsConstructor
public class ServiceLoginUsuario {
    private final RepositoryUsuario  repositoryUsuario;
    private final ServicosGeral servicosGeral;
    private final PasswordEncoder passwordEncoder;


    public String login(String email,String password){
        if (email.isEmpty() || password.isEmpty()){
            throw new CustomException("E-mail ou senha não informados");
        }
        Optional<Usuario> usuarioOptional = repositoryUsuario.findByEmail(email);
        if (!usuarioOptional.isPresent()){
            throw new CustomException("E-mail não cadastrado");
        }
        if (!passwordEncoder.matches(password,usuarioOptional.get().getPassword())){
            throw new CustomException("Senha incorreta");
        }
        return servicosGeral.gerarToken(usuarioOptional.get().getEmail());

    }
}
