package jabpDev.ServicosPro.api.Services.Auth;

import jabpDev.ServicosPro.api.Dto.Response.ResponseGeral;
import jabpDev.ServicosPro.api.Entitys.Usuario;
import jabpDev.ServicosPro.api.Exceptions.CustomExeception.CustomException;
import jabpDev.ServicosPro.api.Repositorys.RepositoryUsuario;
import jabpDev.ServicosPro.api.Services.Email.ServiceEmail;
import jabpDev.ServicosPro.api.Services.Geral.ServicosGeral;
import lombok.AllArgsConstructor;
import org.apache.coyote.Response;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Objects;
import java.util.Optional;
import java.util.Random;

@Service
@AllArgsConstructor
public class ServiceLoginUsuario {
    private final RepositoryUsuario  repositoryUsuario;
    private final ServicosGeral servicosGeral;
    private final PasswordEncoder passwordEncoder;
    private ServiceEmail serviceEmail;


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

    public void enviarCodigo(String email){
        Optional<Usuario> usuario = repositoryUsuario.findByEmail(email);
        if (!usuario.isPresent()){
            throw new CustomException("E-mail não cadastrado");
        }
        Random random = new Random();
        int codigo = 1000 + random.nextInt(9000);
        Usuario salvarCodigo = usuario.get();
        salvarCodigo.setCodigo(codigo);
        repositoryUsuario.save(salvarCodigo);
        serviceEmail.enviarEmailRedefinirSenha(salvarCodigo.getEmail(), salvarCodigo.getNome(),salvarCodigo.getCodigo());
    }

    public void validarCodigo(int codigo, String email){
        Optional<Usuario> usuario = repositoryUsuario.findByEmail(email);
        if (!usuario.isPresent()){
            throw new CustomException("E-mail não cadastrado");
        }
        if(!Objects.equals(codigo, usuario.get().getCodigo())){
            throw new CustomException("Código de verificação errado ou vencido");
        }
    }

    public void redefinirSenha(String email, String senha){
        Optional<Usuario> usuario = repositoryUsuario.findByEmail(email);
        if (!usuario.isPresent()){
            throw new CustomException("E-mail não cadastrado");
        }
        String password = passwordEncoder.encode(senha);
        Usuario salvarSenhaNova = usuario.get();
        salvarSenhaNova.setSenha(password);
        repositoryUsuario.save(salvarSenhaNova);
    }
}
