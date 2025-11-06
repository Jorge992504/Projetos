package jabpDev.dente.api.services;


import jabpDev.dente.api.entitys.Empresa;
import jabpDev.dente.api.exceptions.ErrorException;
import jabpDev.dente.api.repositories.EmpresaRepository;
import lombok.AllArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.Optional;

@Service
@AllArgsConstructor
public class LoginEmpresaService {
    private final EmpresaRepository empresaRepository;
    private final ServicesGerais servicesGerais;
    private final PasswordEncoder passwordEncoder;

    public String login(String email, String password) {
        if (email.isEmpty()){
            throw new ErrorException("Informe o usuário");
        }
        if (password.isEmpty()){
            throw new ErrorException("Informe a senha");
        }
        Optional<Empresa> empresa = empresaRepository.findByEmailClinica(email);
        if (empresa.isPresent()){
            if (passwordEncoder.matches(password, empresa.get().getPassword())){
                return servicesGerais.geraToken(empresa.get().getEmailClinica());
            }else{
                throw new ErrorException("Senha incorreta");
            }
        }else{
            throw new ErrorException("Empresa não cadastrada");
        }

    }

}
