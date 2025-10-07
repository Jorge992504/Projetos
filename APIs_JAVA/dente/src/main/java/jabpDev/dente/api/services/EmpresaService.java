package jabpDev.dente.api.services;


import jabpDev.dente.api.dto.response.EmpresaDtoResponse;
import jabpDev.dente.api.entitys.Empresa;
import jabpDev.dente.api.exceptions.ErrorException;
import jabpDev.dente.api.repositories.EmpresaRepository;
import lombok.AllArgsConstructor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.Optional;

@Service
@AllArgsConstructor
public class EmpresaService {
    private final EmpresaRepository empresaRepository;
    private static final String url = "http://172.16.251.22:5050/api/public/";


    public EmpresaDtoResponse buscaInfoEmpresa()throws IOException {
        String foto;
        String empresa = SecurityContextHolder.getContext().getAuthentication().getName();
        if (empresa.isEmpty()){
            throw new ErrorException("Não autenticado");
        }else{
            Optional<Empresa> optionalEmpresa = empresaRepository.findByEmailClinica(empresa);
            if (optionalEmpresa.isPresent()){
                if (optionalEmpresa.get().getFoto() == null){
                    foto = url + "logoGeral.png";
                }else{
                    foto = url + optionalEmpresa.get().getNomeClinica() + "/" + optionalEmpresa.get().getFoto();
                }
                return new EmpresaDtoResponse(optionalEmpresa.get().getEmailClinica(),optionalEmpresa.get().getNomeClinica(), foto);
            }else{
                throw new ErrorException("Empresa não encontrada");
            }

        }

    }
}
