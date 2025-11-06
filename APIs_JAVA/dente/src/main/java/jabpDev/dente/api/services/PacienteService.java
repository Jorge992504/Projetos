package jabpDev.dente.api.services;


import jabpDev.dente.api.dto.request.RegistrarPacienteDtoRequest;
import jabpDev.dente.api.dto.response.HistoricoDocumentosResponse;
import jabpDev.dente.api.dto.response.PacienteDtoResponse;
import jabpDev.dente.api.entitys.Empresa;
import jabpDev.dente.api.entitys.Paciente;
import jabpDev.dente.api.exceptions.ErrorException;
import jabpDev.dente.api.repositories.EmpresaRepository;
import jabpDev.dente.api.repositories.PacienteRepository;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.io.File;
import java.util.*;
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
        if (!servicesGerais.isValidCPF(body.cpf())){
                throw new ErrorException("CNPJ não é valido");
        }

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

    public ResponseEntity<?> buscaDocumentos(Long pacienteId, HttpServletRequest request){
        String basePath = "src/main/resources/static/public";
        String nmEmpresa =  SecurityContextHolder.getContext().getAuthentication().getName();
        Optional<Empresa> empresa = empresaRepository.findByEmailClinica(nmEmpresa);
        if (empresa.isEmpty()){
            throw new ErrorException("Sem permissão para cadastrar dentista.\nRealizar login novamente");
        }

        Optional<Paciente> paciente = pacienteRepository.findByIdAndEmpresaId(pacienteId, empresa.get().getId());
        if (paciente.isEmpty()){
            throw new ErrorException("Paciente não encontrado");
        }


        File pastaPaciente = new File(basePath + "/" + empresa.get().getId() + "/" + paciente.get().getId());
        if (!pastaPaciente.exists() || !pastaPaciente.isDirectory()) {
            return ResponseEntity.ok(Collections.emptyList());
        }

        List<Map<String, Object>> resultado = new ArrayList<>();

        for (File pastaData : Objects.requireNonNull(pastaPaciente.listFiles())) {
            if (pastaData.isDirectory()) {
                Map<String, Object> item = new LinkedHashMap<>();
                item.put("data", pastaData.getName());

                List<String> arquivos = new ArrayList<>();
                for (File arquivo : Objects.requireNonNull(pastaData.listFiles())) {
                    if (arquivo.isFile()) {
                        String url = servicesGerais.baseUrl + empresa.get().getId() + "/" + paciente.get().getId() + "/" +
                                pastaData.getName() + "/" + arquivo.getName();
                        arquivos.add(url);
                    }
                }

                item.put("arquivos", arquivos);
                resultado.add(item);
            }
        }

        resultado.sort((a, b) -> ((String) b.get("data")).compareTo((String) a.get("data")));
        return ResponseEntity.ok(resultado);

    }
}
