package jabpDev.dente.api.services;


import jabpDev.dente.api.dto.request.RegistrarConvenioRequest;
import jabpDev.dente.api.dto.response.BuscarServicosDtoResponse;
import jabpDev.dente.api.dto.response.ListarConvenioResponse;
import jabpDev.dente.api.entitys.Convenio;
import jabpDev.dente.api.entitys.Empresa;
import jabpDev.dente.api.entitys.Servicos;
import jabpDev.dente.api.exceptions.ErrorException;
import jabpDev.dente.api.repositories.ConvenioRepository;
import jabpDev.dente.api.repositories.EmpresaRepository;
import jabpDev.dente.api.repositories.ServicosRepository;
import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
public class ConvenioService {

    private final EmpresaRepository empresaRepository;
    private final ConvenioRepository convenioRepository;
    private final ServicosRepository servicosRepository;


    @Transactional
    public void incluirConvenio(RegistrarConvenioRequest body){

        if (body.tratamento() == 0){
            throw new ErrorException("Informar qual serviço é coberto pelo convenio");
        }
        if (body.valorPago() == 0){
            throw new ErrorException("Informar o valor que é coberto pelo convenio");
        }
        if (body.parceiro().isEmpty()){
            throw new ErrorException("Informe o nome da empresa parceira");
        }

        String nmEmpresa =  SecurityContextHolder.getContext().getAuthentication().getName();
        Optional<Empresa> empresa = empresaRepository.findByEmailClinica(nmEmpresa);
        if (empresa.isEmpty()){
            throw new ErrorException("Realizar login novamente");
        }
        Optional<Servicos> servico = servicosRepository.findByIdAndEmpresaId(body.tratamento(), empresa.get().getId());
        if (!servico.isPresent()){
            throw new ErrorException("Serviço não cadastrado para a empresa");
        }
        Convenio convenio = Convenio.builder()
                .servico(servico.get())
                .parceiro(body.parceiro())
                .valor_pago(body.valorPago())
                .empresa(empresa.get())
                .build();
        Convenio response = convenioRepository.save(convenio);
        if (response.getId() < 0){
            throw new ErrorException("Erro ao incluir convenio");
        }


    }


    public List<ListarConvenioResponse> buscarConvenio(){

        String nmEmpresa =  SecurityContextHolder.getContext().getAuthentication().getName();
        Optional<Empresa> empresa = empresaRepository.findByEmailClinica(nmEmpresa);
        if (empresa.isEmpty()){
            throw new ErrorException("Realizar login novamente");
        }

        List<Convenio> response = convenioRepository.findByEmpresaId(empresa.get().getId());

        return response.stream()
                .map(c -> {
                    return new ListarConvenioResponse(
                            c.getParceiro(),
                            c.getServico().getNome(),
                            c.getValor_pago()
                    );
                }).collect(Collectors.toList());

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
