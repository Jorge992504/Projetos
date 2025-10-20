package jabpDev.dente.api.services;


import jabpDev.dente.api.dto.request.RegistrarEmpresaDtoRequest;
import jabpDev.dente.api.dto.response.EmpresaDtoResponse;
import jabpDev.dente.api.entitys.Empresa;
import jabpDev.dente.api.exceptions.ErrorException;
import jabpDev.dente.api.repositories.EmpresaRepository;
import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.io.*;
import java.util.Base64;
import java.util.Optional;

@Service
@AllArgsConstructor
public class EmpresaService {
    private final EmpresaRepository empresaRepository;
    private final ServicesGerais servicesGerais;



    public EmpresaDtoResponse buscaInfoEmpresa(){
        String foto;
        String empresa = SecurityContextHolder.getContext().getAuthentication().getName();
        if (empresa.isEmpty()){
            throw new ErrorException("Não autenticado");
        }else{
            Optional<Empresa> optionalEmpresa = empresaRepository.findByEmailClinica(empresa);
            if (optionalEmpresa.isPresent()){
                if (optionalEmpresa.get().getFoto() == null){

                    foto = servicesGerais.baseUrl + "logoGeral.png";
                }else{
                    foto = servicesGerais.baseUrl + optionalEmpresa.get().getNomeClinica() + "/" + optionalEmpresa.get().getFoto();
                }
                return new EmpresaDtoResponse(foto,
                        optionalEmpresa.get().getNomeClinica(),
                        optionalEmpresa.get().getEmailClinica(),
                        optionalEmpresa.get().getTelefone(),
                        optionalEmpresa.get().getEndereco(),
                        optionalEmpresa.get().getCnpj()
                        );
            }else{
                throw new ErrorException("Empresa não encontrada");
            }
        }
    }


    @Transactional
    public void editarDadosEmpresa( RegistrarEmpresaDtoRequest body){
        String email = SecurityContextHolder.getContext().getAuthentication().getName();
        Optional<Empresa> empresa = empresaRepository.findByEmailClinica(email);
        if (!empresa.isPresent()){
            throw new ErrorException("Clinica não cadastrada");
        }else{
            String uploadDir = new File("src/main/resources/static/public/" + body.nomeClinica()).getAbsolutePath();
            File directory = new File(uploadDir);
            if (!directory.exists()) {
                boolean created = directory.mkdirs();
                if (!created) {
                    throw new ErrorException("Não foi possível criar o diretório: " + uploadDir);
                }
            }
            String nomeFoto = body.nomeClinica().replaceAll("\\s+", "_") + ".png";
            File destino = new File(directory, nomeFoto);
            String fotoBD = servicesGerais.baseUrl + empresa.get().getNomeClinica() + "/" + empresa.get().getFoto();
            if ( !body.foto().equals(fotoBD)){
                if (body.foto() != null && !body.foto().isEmpty()) {
                    String fotoBase64 = body.foto();
                    if (fotoBase64.contains(",")) {
                        fotoBase64 = fotoBase64.split(",")[1];
                    }
                    byte[] fotoBy = Base64.getDecoder().decode(fotoBase64);
                    try (OutputStream stream = new FileOutputStream(destino)) {
                        stream.write(fotoBy);
                    } catch (FileNotFoundException e) {
                        throw new ErrorException("Erro ao salvar foto");
                    } catch (IOException e) {
                        throw new ErrorException("Erro ao salvar foto");
                    }
                }
            }

//            if (!servicesGerais.isValid(body.cnpj())){
//                throw new ErrorException("CNPJ não é valido");
//            }


            Empresa empresaNew = empresa.get();
            empresaNew.setCnpj(body.cnpj());
            empresaNew.setFoto(body.foto() != null ? nomeFoto : null);
            empresaNew.setEndereco(body.endereco());
            empresaNew.setNomeClinica(body.nomeClinica());
            empresaRepository.save(empresaNew);
        }

    }
}