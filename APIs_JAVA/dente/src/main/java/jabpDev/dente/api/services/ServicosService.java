package jabpDev.dente.api.services;


import jabpDev.dente.api.dto.request.RegistrarServicosDtoRequest;
import jabpDev.dente.api.dto.response.BuscarServicosDtoResponse;
import jabpDev.dente.api.entitys.Empresa;
import jabpDev.dente.api.entitys.Servicos;
import jabpDev.dente.api.exceptions.ErrorException;
import jabpDev.dente.api.repositories.EmpresaRepository;
import jabpDev.dente.api.repositories.ServicosRepository;
import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
public class ServicosService {

    private final EmpresaRepository empresaRepository;
    private final ServicosRepository servicosRepository;


    @Transactional
    public void registrarServicosClinica(RegistrarServicosDtoRequest body){
        if (body.nome().isEmpty()){
            throw new ErrorException("Descrição do serviço obrigatoria");
        }

        String nmEmpresa =  SecurityContextHolder.getContext().getAuthentication().getName();
        Optional<Empresa> empresa = empresaRepository.findByEmailClinica(nmEmpresa);
        if (empresa.isEmpty()){
            throw new ErrorException("Sem permissão para cadastrar dentista.\nRealizar login novamente");
        }

        Servicos servicos = Servicos.builder()
                .nome(body.nome())
                .vl(body.vl())
                .empresa(empresa.get())
                .build();
        Servicos response = servicosRepository.save(servicos);
        if (response.getId() < 0){
            throw new ErrorException("Erro ao registrar o serviço informado");
        }
    }




    public List<BuscarServicosDtoResponse> buscarServicos(){
        String nmEmpresa =  SecurityContextHolder.getContext().getAuthentication().getName();
        Optional<Empresa> empresa = empresaRepository.findByEmailClinica(nmEmpresa);
        if (empresa.isEmpty()){
            throw new ErrorException("Sem permissão para cadastrar dentista.\nRealizar login novamente");
        }

        List<BuscarServicosDtoResponse> response = servicosRepository.findByEmpresaId(empresa.get().getId());

        return response.stream()
                .map(s -> {
                    return new BuscarServicosDtoResponse(
                            s.id(),
                            s.nome(),
                            s.vl()
                    );
                }).collect(Collectors.toList());
    }
}
