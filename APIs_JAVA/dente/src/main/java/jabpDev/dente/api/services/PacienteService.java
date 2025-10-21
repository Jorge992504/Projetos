package jabpDev.dente.api.services;


import jabpDev.dente.api.dto.request.RegistrarPacienteDtoRequest;
import jabpDev.dente.api.dto.response.PacienteDtoResponse;
import jabpDev.dente.api.entitys.Empresa;
import jabpDev.dente.api.entitys.Paciente;
import jabpDev.dente.api.exceptions.ErrorException;
import jabpDev.dente.api.repositories.EmpresaRepository;
import jabpDev.dente.api.repositories.PacienteRepository;
import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
public class PacienteService {

    private final PacienteRepository pacienteRepository;
    private final ServicesGerais servicesGerais;
    private final EmpresaRepository empresaRepository;


    public List<PacienteDtoResponse> buscaPacientePorCPF(){
        String empresa = SecurityContextHolder.getContext().getAuthentication().getName();
        if (empresa.isEmpty()){
            throw new ErrorException("Não autenticado");
        }
        Optional<Empresa> emp = empresaRepository.findByEmailClinica(empresa);
        List<PacienteDtoResponse> response = pacienteRepository.findByEmpresaId(emp.get().getId());
        return response.stream().map( p -> {
            return new PacienteDtoResponse(
                    p.nome(),
                    p.telefone(),
                    p.cpf(),
                    p.email()
            );
        }).collect(Collectors.toList());
    }
    @Transactional
    public Paciente registrarPaciente(RegistrarPacienteDtoRequest body){
        if (body.email().isEmpty()){
            throw new ErrorException("E-mail não informado");
        }
        if (body.cpf().isEmpty()){
            throw new ErrorException("CPF não informado");
        }
//        if (!servicesGerais.isValidCPF(body.cpf())){
//                throw new ErrorException("CNPJ não é valido");
//        }

        String nmEmpresa =  SecurityContextHolder.getContext().getAuthentication().getName();
        Optional<Empresa> empresa = empresaRepository.findByEmailClinica(nmEmpresa);
        if (empresa.isEmpty()){
            throw new ErrorException("Sem permissão para cadastrar dentista.\nRealizar login novamente");
        }

        Paciente paciente = Paciente.builder()
                .nome(body.nome())
                .email(body.email())
                .rg(body.rg())
                .endereco(body.endereco())
                .telefone(body.telefone())
                .cpf(body.cpf())
                .empresaId(empresa.get().getId())
                .build();

        Paciente response = pacienteRepository.save(paciente);
        if (response.getId() > 0 ){
            servicesGerais.enviaEmailCadastroPaciente(response.getEmail(),response.getNome(),empresa.get().getEmailClinica());
            return response;
        }else{
            throw new ErrorException("Erro ao registrar paciente");
        }


    }
}
