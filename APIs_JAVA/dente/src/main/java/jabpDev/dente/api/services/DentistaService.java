package jabpDev.dente.api.services;


import jabpDev.dente.api.dto.request.RegistrarDentistaDtoRequest;
import jabpDev.dente.api.dto.response.BuscaDentistasDtoResponse;
import jabpDev.dente.api.entitys.Dentista;
import jabpDev.dente.api.entitys.Empresa;
import jabpDev.dente.api.exceptions.ErrorException;
import jabpDev.dente.api.repositories.DentistaRepository;
import jabpDev.dente.api.repositories.EmpresaRepository;
import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
public class DentistaService {

    private final DentistaRepository dentistaRepository;
    private final ServicesGerais servicesGerais;
    private final EmpresaRepository empresaRepository;


    @Transactional
    public void registrarDentista(RegistrarDentistaDtoRequest body){
        if (body.email().isEmpty()){
            throw new ErrorException("E-mail não informado");
        }
        if (body.cro().isEmpty()){
            throw new ErrorException("CRO não informado");
        }
        if (body.nome().isEmpty()){
            throw new ErrorException("Nome não informado");
        }

        String nmEmpresa =  SecurityContextHolder.getContext().getAuthentication().getName();
        Optional<Empresa> empresa = empresaRepository.findByEmailClinica(nmEmpresa);
        if (empresa.isEmpty()){
            throw new ErrorException("Sem permissão para cadastrar dentista.\nRealizar login novamente");
        }

        Dentista dentista = Dentista.builder()
                .cro(body.cro())
                .email(body.email())
                .empresaId(empresa.get().getId())
                .telefone(body.telefone())
                .nome(body.nome())
                .ativo(true)
                .build();
        Dentista response = dentistaRepository.save(dentista);
        if (response.getId() > 0){
            servicesGerais.enviaEmailCadastroDentista(response.getEmail(),response.getNome(),empresa.get().getEmailClinica());
        }else{
            throw new ErrorException("Erro ao realizar cadastro");
        }
    }



    public List<BuscaDentistasDtoResponse> buscaDentistas(){
        String nmEmpresa =  SecurityContextHolder.getContext().getAuthentication().getName();
        Optional<Empresa> empresa = empresaRepository.findByEmailClinica(nmEmpresa);
        if (empresa.isEmpty()){
            throw new ErrorException("Sem permissão para cadastrar dentista.\nRealizar login novamente");
        }

        List<BuscaDentistasDtoResponse> response = dentistaRepository.findByEmpresaId(empresa.get().getId());

        return response.stream()
                .map(d -> {
                    return new BuscaDentistasDtoResponse(
                            d.id(),
                            d.nome(),
                            d.email(),
                            d.cro(),
                            d.telefone(),
                            d.ativo()
                    );
                }).collect(Collectors.toList());
    }

    @Transactional
    public BuscaDentistasDtoResponse inativarAtivarDentista(String email){
        String nmEmpresa =  SecurityContextHolder.getContext().getAuthentication().getName();
        Optional<Empresa> empresa = empresaRepository.findByEmailClinica(nmEmpresa);
        if (empresa.isEmpty()){
            throw new ErrorException("Sem permissão para cadastrar dentista.\nRealizar login novamente");
        }

        Optional<Dentista> dentista = dentistaRepository.findByEmailAndEmpresaId(email,empresa.get().getId());
        if (dentista.isEmpty()){
            throw new ErrorException("Dentista não encontrado");
        }

        dentista.get().setAtivo(!dentista.get().isAtivo());
        Dentista response = dentistaRepository.save(dentista.get());

        return new BuscaDentistasDtoResponse(
                response.getId(),
                response.getNome(),
                response.getEmail(),
                response.getCro(),
                response.getTelefone(),
                response.isAtivo()
        );
    }
}
