package jabpDev.dente.api.services;


import jabpDev.dente.api.dto.request.RegistrarEmpresaDtoRequest;
import jabpDev.dente.api.entitys.Empresa;
import jabpDev.dente.api.entitys.Premium;
import jabpDev.dente.api.exceptions.ErrorException;
import jabpDev.dente.api.repositories.EmpresaRepository;
import jabpDev.dente.api.repositories.PremiumRepository;
import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.io.*;
import java.time.LocalDate;
import java.util.Base64;

@Service
@AllArgsConstructor
public class RegistrarEmpresaService {


    private final EmpresaRepository empresaRepository;
    private final PasswordEncoder passwordEncoder;
    private final ServicesGerais servicesGerais;
    private final PremiumRepository premiumRepository;

    @Transactional
    public String registrarEmpresa(RegistrarEmpresaDtoRequest body)  {

        String password = passwordEncoder.encode(body.passowrd());

        if (!servicesGerais.isValid(body.cnpj())){
            throw new ErrorException("CNPJ não é valido");
        }


        Empresa empresa = Empresa.builder()
                .nomeClinica(body.nomeClinica())
                .emailClinica(body.emailClinica())
                .cnpj(body.cnpj())
                .endereco(body.endereco())
                .telefone(body.telefone())
                .password(password)
//                .foto(body.foto() != null ? nomeFoto : null)
                .dataRegistro(LocalDate.now())
                .build();
        Empresa response = empresaRepository.save(empresa);
        if (response.getId() < 0 ){
            throw new ErrorException("Erro ao realizar cadastro");
        }

        Premium premium = Premium.builder()
                .dataPremium(LocalDate.now())
                .periodoTeste(true)
                .premium(false)
                .build();
        premiumRepository.save(premium);


//        String uploadDir = new File("src/main/resources/static/public/" + response.getId()).getAbsolutePath();
        String uploadDir = new File("/home/ec2-user/dente/uploads/public/" + response.getId()).getAbsolutePath();

        File directory = new File(uploadDir);
        if (!directory.exists()) {
            boolean created = directory.mkdirs();
            if (!created) {
                throw new ErrorException("Não foi possível criar o diretório: " + uploadDir);
            }
        }

        String nomeFoto = response.getId() + ".png";
        File destino = new File(directory, nomeFoto);

        if (body.foto() != null && !body.foto().isEmpty()) {
            String fotoBase64 = body.foto();
            if (fotoBase64.contains(",")) {
                fotoBase64 = fotoBase64.split(",")[1];
            }
            byte[] fotoBy = Base64.getDecoder().decode(fotoBase64);
            try (OutputStream stream = new FileOutputStream(destino)) {
                stream.write(fotoBy);
            } catch (FileNotFoundException e) {
                throw new ErrorException(e.getMessage());
            } catch (IOException e) {
                throw new ErrorException(e.getMessage());
            }
        }

        response.setFoto(body.foto() != null ? nomeFoto : null);
        empresaRepository.save(response);

        servicesGerais.enviarEmailCadastro(response.getEmailClinica(), response.getNomeClinica());
        return servicesGerais.geraToken(response.getEmailClinica());
    }
}
