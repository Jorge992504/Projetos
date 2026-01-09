package jabpDev.ServicosPro.api.Services.Auth;

import jabpDev.ServicosPro.api.Dto.Request.RequestUsuario;
import jabpDev.ServicosPro.api.Entitys.Categorias;
import jabpDev.ServicosPro.api.Entitys.Usuario;
import jabpDev.ServicosPro.api.Exceptions.CustomExeception.CustomException;
import jabpDev.ServicosPro.api.Repositorys.RepositoryCategorias;
import jabpDev.ServicosPro.api.Repositorys.RepositoryUsuario;
import jabpDev.ServicosPro.api.Services.Email.ServiceEmail;
import jabpDev.ServicosPro.api.Services.Geral.ServicosGeral;
import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.time.LocalDate;
import java.util.Base64;
import java.util.Optional;

@Service
@AllArgsConstructor
public class ServiceRegistrarUsuario {
    private RepositoryUsuario repositoryUsuario;
    private ServicosGeral servicosGeral;
    private PasswordEncoder passwordEncoder;
    private RepositoryCategorias repositoryCategorias;
    private ServiceEmail serviceEmail;

    @Transactional
    public String registrarUsuario(RequestUsuario requestUsuario)throws IOException {
        try {
            if (!requestUsuario.termosPolitica() || requestUsuario.senha().isEmpty() || requestUsuario.email().isEmpty()){
                throw new CustomException("Faltam dados para realizar o cadastro");
            }
            Optional<Usuario> usuario = repositoryUsuario.findByEmail(requestUsuario.email());
            if (usuario.isPresent()){
                throw new CustomException("E-mail já cadastrado");
            }
            String password = passwordEncoder.encode(requestUsuario.senha());
            Usuario usuarioNovo = Usuario.builder()
                    .nome(requestUsuario.nome())
                    .email(requestUsuario.email())
                    .senha(password)
                    .termosPolitica(true)
                    .dataRegistro(LocalDate.now())
                    .build();
            Usuario response = repositoryUsuario.save(usuarioNovo);
            if(response.getId()< 0){
                throw new CustomException("Não foi possível realizar o cadastro");
            }
            if (!requestUsuario.foto().isEmpty()){
                String uploadDir = new File(servicosGeral.getUrlInterna()+ response.getId()).getAbsolutePath();
                File directorio = new File(uploadDir);
                if (!directorio.exists()){
                    boolean crearDirectorio = directorio.mkdirs();
                    if (!crearDirectorio){
                        throw new CustomException("Não foi possível guardar a foto de perfil, Tente atualizar mais tarde.");
                    }
                }
                String nomeFoto = response.getId() + ".png";
                File destino = new File(directorio,nomeFoto);
                String fotoBase64 = requestUsuario.foto();
                if (fotoBase64.contains(",")){
                    fotoBase64 = fotoBase64.split(",")[1];
                }
                byte[] fotoFinal = Base64.getDecoder().decode(fotoBase64);
                OutputStream stream = new FileOutputStream(destino);
                stream.write(fotoFinal);

                response.setFoto(nomeFoto);
                repositoryUsuario.save(response);
            }
            return servicosGeral.gerarToken(response.getEmail());
        }catch (CustomException customException){
            throw new CustomException(customException.getMessage());
        }
    }

    @Transactional
    public ResponseEntity<?> registrarCategoriaUsuario(RequestUsuario requestUsuario){
            Usuario usuario = servicosGeral.getUsuario();
            usuario.setTipoUsuario(requestUsuario.tipoUsuario());
            usuario.setTipoPessoa(requestUsuario.tipoPessoa());
            usuario.setCpf_cnpj(requestUsuario.cpf_cnpj());
            usuario.setDataNascimento(requestUsuario.dataNascimento());
            usuario.setTelefone(requestUsuario.telefone());
            usuario.setEndereco(requestUsuario.endereco());
            if (requestUsuario.categoriaPrestador() > 0){
                Optional<Categorias> categoria = repositoryCategorias.findById(requestUsuario.categoriaPrestador());
                categoria.ifPresent(usuario::setCategoriaPrestador);
            }
            Usuario response = repositoryUsuario.save(usuario);
            if (!response.getTipoUsuario().isEmpty()){
                serviceEmail.enviarEmailCadastro(response.getEmail(),response.getNome());
                return ResponseEntity.status(201).build();
            }else{
                return ResponseEntity.status(401).build();
            }
    }
}
