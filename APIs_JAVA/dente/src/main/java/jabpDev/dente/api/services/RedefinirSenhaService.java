package jabpDev.dente.api.services;

import jabpDev.dente.api.dto.response.RedefinirSenhaDtoResponse;
import jabpDev.dente.api.entitys.Empresa;
import jabpDev.dente.api.entitys.Password;
import jabpDev.dente.api.exceptions.ErrorException;
import jabpDev.dente.api.repositories.EmpresaRepository;
import jabpDev.dente.api.repositories.RedefinirSenhaRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Optional;
import java.util.Random;

@Service
@AllArgsConstructor
public class RedefinirSenhaService {
    private final EmpresaRepository empresaRepository;
    private final ServicesGerais servicesGerais;
    private final RedefinirSenhaRepository redefinirSenhaRepository;

    public void enviarCodigoRedefinirSenha(String email){
        if (email.isEmpty()){
            throw new ErrorException("Informe o e-mail para o envio do código");
        }
        Random random = new Random();
        int codigo = 1000 + random.nextInt(9000);
        Optional<Empresa> empresa = empresaRepository.findByEmailClinica(email);
        if (empresa.isPresent()){
            Password password = Password.builder().empresaId(empresa.get().getId()).codigo(codigo).build();
            Password save = redefinirSenhaRepository.save(password);
            if (password.getCodigo() > 0){
                servicesGerais.enviarEmailRedefinirSenha(empresa.get().getEmailClinica(), codigo);
            }else{
                throw new ErrorException("Erro ao gerar código de verificação");
            }
        }else{
            throw new ErrorException("Empresa não encontrada");
        }
    }
}
