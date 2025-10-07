package jabpDev.dente.api.services;


import jabpDev.dente.api.dto.request.RegistrarEmpresaDtoRequest;
import jabpDev.dente.api.entitys.Empresa;
import jabpDev.dente.api.exceptions.ErrorException;
import jabpDev.dente.api.repositories.EmpresaRepository;
import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Base64;

@Service
@AllArgsConstructor
public class RegistrarEmpresaService {


    private final EmpresaRepository empresaRepository;
    private final PasswordEncoder passwordEncoder;
    private final ServicesGerais servicesGerais;

    @Transactional
    public String registrarEmpresa(RegistrarEmpresaDtoRequest body) throws IOException {

        String password = passwordEncoder.encode(body.passowrd());
        String uploadDir = new File("src/main/resources/static/public/" + body.nomeClinica()).getAbsolutePath();
        File directory = new File(uploadDir);
        if (!directory.exists()) {
            boolean created = directory.mkdirs();
            if (!created) {
                throw new IOException("Não foi possível criar o diretório: " + uploadDir);
            }
        }

        String nomeFoto = body.nomeClinica().replaceAll("\\s+", "_") + ".png";
        File destino = new File(directory, nomeFoto);

        if (body.foto() != null && !body.foto().isEmpty()) {
            String fotoBase64 = body.foto();
            if (fotoBase64.contains(",")) {
                fotoBase64 = fotoBase64.split(",")[1];
            }
            byte[] fotoBy = Base64.getDecoder().decode(fotoBase64);
            try (OutputStream stream = new FileOutputStream(destino)) {
                stream.write(fotoBy);
            }
        }


        Empresa empresa = Empresa.builder()
                .nomeClinica(body.nomeClinica())
                .emailClinica(body.emailClinica())
                .cnpj(body.cnpj())
                .endereco(body.endereco())
                .telefone(body.telefone())
                .password(password)
                .foto(body.foto() != null ? nomeFoto : null)
                .build();
        Empresa response = empresaRepository.save(empresa);
        if (response.getId() > 0 ){
            return servicesGerais.geraToken(response.getEmailClinica());
        }else{
            throw new ErrorException("Erro ao realizar cadastro");
        }
    }
}
