package jabpDev.dente.api.services;

import jabpDev.dente.api.entitys.Empresa;
import jabpDev.dente.api.entitys.Plano;
import jabpDev.dente.api.exceptions.ErrorException;
import jabpDev.dente.api.repositories.EmpresaRepository;
import jabpDev.dente.api.repositories.PlanoRepository;
import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.Optional;

@Service
@AllArgsConstructor
public class PlanoService {

    private final PlanoRepository planoRepository;
    private final EmpresaRepository empresaRepository;

    @Transactional
    public String verificaPlano(){

        String nmEmpresa =  SecurityContextHolder.getContext().getAuthentication().getName();
        Optional<Empresa> empresa = empresaRepository.findByEmailClinica(nmEmpresa);
        if (empresa.isEmpty()){
            throw new ErrorException("Realizar login novamente");
        }

        Optional<Plano> plano = planoRepository.findByEmpresaId(empresa.get().getId());
        LocalDate dataAtual = LocalDate.now();
        if (plano.get().getPeriodoTeste()){
            if (!dataAtual.isAfter(plano.get().getDataTeste().plusDays(30))){
                return "Teste";
            }else{
                Plano planoAtualizar = plano.get();
                planoAtualizar.setPeriodoTeste(false);
                planoRepository.save(planoAtualizar);
                return "!Teste";
            }
        }else if (plano.get().getPlano()){
            String periodo = plano.get().getPeriodo();
            if (periodo.equals("Mensal")){
                if (!dataAtual.isAfter(plano.get().getDataInicio().plusDays(30))){
                    return "Plano";
                }else{
                    Plano planoAtualizar = plano.get();
                    planoAtualizar.setPlano(false);
                    planoRepository.save(planoAtualizar);
                    return "Finalizado";
                }
            }else if(periodo.equals("Semestral")){
                LocalDate fimSemestre = plano.get().getDataInicio().plusDays(180);
                if (!dataAtual.isAfter(fimSemestre)) {
                    return "Plano";
                } else {
                    Plano planoAtualizar = plano.get();
                    planoAtualizar.setPlano(false);
                    planoRepository.save(planoAtualizar);
                    return "Finalizado";
                }
            }else if(periodo.equals("Anual")){
                LocalDate fimAno = plano.get().getDataInicio().plusDays(365);

                if (!dataAtual.isAfter(fimAno)) {
                    return "Plano";
                } else {
                    Plano planoAtualizar = plano.get();
                    planoAtualizar.setPlano(false);
                    planoRepository.save(planoAtualizar);
                    return "Finalizado";
                }
            }
        }
        return "!Plano";
    }

    @Transactional
    public void assinarPlano(){
        String nmEmpresa =  SecurityContextHolder.getContext().getAuthentication().getName();
        Optional<Empresa> empresa = empresaRepository.findByEmailClinica(nmEmpresa);
        if (empresa.isEmpty()){
            throw new ErrorException("Realizar login novamente");
        }
    }
}




