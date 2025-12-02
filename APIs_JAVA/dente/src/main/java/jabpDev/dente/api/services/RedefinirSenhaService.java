package jabpDev.dente.api.services;

import jabpDev.dente.api.dto.request.RedefinirSenhaDtoRequest;
import jabpDev.dente.api.entitys.Empresa;
import jabpDev.dente.api.entitys.Password;
import jabpDev.dente.api.exceptions.ErrorException;
import jabpDev.dente.api.repositories.EmpresaRepository;
import jabpDev.dente.api.repositories.RedefinirSenhaRepository;
import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

//import javax.swing.text.html.Option;
import java.util.Optional;
import java.util.Random;

@Service
@AllArgsConstructor
public class RedefinirSenhaService {
    private final EmpresaRepository empresaRepository;
    private final ServicesGerais servicesGerais;
    private final RedefinirSenhaRepository redefinirSenhaRepository;
    private final PasswordEncoder passwordEncoder;

    public void enviarCodigoRedefinirSenha(String email){
        if (email.isEmpty()){
            throw new ErrorException("Informe o e-mail para o envio do código");
        }
        Random random = new Random();
        int codigo = 1000 + random.nextInt(9000);
        Optional<Empresa> empresa = empresaRepository.findByEmailClinica(email);
        if (empresa.isPresent()){
            Password password = Password.builder().empresa(empresa.get()).codigo(codigo).build();
            Password save = redefinirSenhaRepository.save(password);
            if (password.getCodigo() > 0){
                servicesGerais.enviarEmailRedefinirSenha(empresa.get().getEmailClinica(), codigo, empresa.get().getNomeClinica());
            }else{
                throw new ErrorException("Erro ao gerar código de verificação");
            }
        }else{
            throw new ErrorException("Empresa não encontrada");
        }
    }

    public void verificarCodigo(RedefinirSenhaDtoRequest body){
        if (body.email().isEmpty()){
            throw new ErrorException("E-mail não informado");
        }
        if (body.codigo() == 0){
            throw new ErrorException("Código não informado");
        }
        Optional<Empresa> empresa = empresaRepository.findByEmailClinica(body.email());
        if (!empresa.isPresent()){
            throw new ErrorException("E-mail não cadastrado para nenhuma empresa");
        }else{
            Optional<Password> password = redefinirSenhaRepository.findByCodigo(body.codigo());
            if(!password.isPresent()){
                throw new ErrorException("Código não encontrado");
            }
            if (password.get().getEmpresa().getId().equals(empresa.get().getId())){
                redefinirSenhaRepository.deleteById(password.get().getId());
            }else{
                throw new ErrorException("Código invalido");
            }
        }
    }

    @Transactional
    public void redefinirSenha(RedefinirSenhaDtoRequest body){
        if (body.email().isEmpty()){
            throw new ErrorException("E-mail não informado");
        }
        if (body.password().isEmpty()){
            throw new ErrorException("Senha não informada");
        }
        Optional<Empresa> empresa = empresaRepository.findByEmailClinica(body.email());
        if (empresa.isPresent()){
            String password = passwordEncoder.encode(body.password());
            Empresa empresaNew = empresa.get();
            empresaNew.setPassword(password);
            empresaRepository.save(empresaNew);
        }else{
            throw new ErrorException("E-mail não cadastrado para nenhuma clinica");
        }

    }
}
