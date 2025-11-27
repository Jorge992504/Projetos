package jabpDev.dente.api.services;

import jabpDev.dente.api.entitys.Empresa;
import jabpDev.dente.api.entitys.Premium;
import jabpDev.dente.api.exceptions.ErrorException;
import jabpDev.dente.api.repositories.EmpresaRepository;
import jabpDev.dente.api.repositories.PremiumRepository;
import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.Optional;

@Service
@AllArgsConstructor
public class PremiumService {

    private final PremiumRepository premiumRepository;
    private final EmpresaRepository empresaRepository;

    @Transactional
    private boolean verificaPeriodoTeste(){

        String nmEmpresa =  SecurityContextHolder.getContext().getAuthentication().getName();
        Optional<Empresa> empresa = empresaRepository.findByEmailClinica(nmEmpresa);
        if (empresa.isEmpty()){
            throw new ErrorException("Realizar login novamente");
        }

        Optional<Premium> premium = premiumRepository.findByEmpresaId(empresa.get().getId());
        LocalDate dataAtual = LocalDate.now();
        if (!premium.get().getPeriodoTeste()){
            if (dataAtual.isAfter(premium.get().getDataTeste().plusDays(15))){
                //ainda nao passou do periodo de teste
                return true;
            }else{
                //ja passou do periodo
                Premium premiumAtualizar = premium.get();
                premiumAtualizar.setPeriodoTeste(false);
                premiumRepository.save(premiumAtualizar);
                return false;
            }
        }else{
            //ja passou do periodo
            return false;
        }

    }

    public boolean verificaPremium(){

        String nmEmpresa =  SecurityContextHolder.getContext().getAuthentication().getName();
        Optional<Empresa> empresa = empresaRepository.findByEmailClinica(nmEmpresa);
        if (empresa.isEmpty()){
            throw new ErrorException("Realizar login novamente");
        }
        boolean periodoTeste = verificaPeriodoTeste();
        if (!periodoTeste){
            Optional<Premium> premium = premiumRepository.findByEmpresaId(empresa.get().getId());
            LocalDate dataAtual = LocalDate.now();
            if (premium.get().getPremium()){
                if (!dataAtual.isAfter(premium.get().getDataTeste().plusDays(30))){
                    return true;
                }else{
                    Premium premiumAtualizar = premium.get();
                    premiumAtualizar.setPremium(false);
                    premiumRepository.save(premiumAtualizar);
                    return false;
                }
            }else{
                return false;
            }
        }else{
            return true;
        }

    }

}




