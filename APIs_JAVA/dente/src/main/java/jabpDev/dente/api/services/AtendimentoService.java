package jabpDev.dente.api.services;


import jabpDev.dente.api.entitys.Empresa;
import jabpDev.dente.api.exceptions.ErrorException;
import jabpDev.dente.api.repositories.AtendimentoRepository;
import jabpDev.dente.api.repositories.EmpresaRepository;
import lombok.AllArgsConstructor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.nio.file.Files;
import java.sql.Date;
import java.time.LocalDate;
import java.util.Optional;

@Service
@AllArgsConstructor
public class AtendimentoService {
    private final AtendimentoRepository atendimentoRepository;
    private final AgendamentoService agendamentoService;
    private final EmpresaRepository empresaRepository;

    public void finalizarAtendimento(MultipartFile[] files,String atendimento,Long agendamentoId,Long pacienteId){
        String nmEmpresa =  SecurityContextHolder.getContext().getAuthentication().getName();
        Optional<Empresa> empresa = empresaRepository.findByEmailClinica(nmEmpresa);
        if (empresa.isEmpty()){
            throw new ErrorException("Sem permissão para cadastrar dentista.\nRealizar login novamente");
        }

        String uploadDir = new File("src/main/resources/static/public/" + empresa.get().getId()).getAbsolutePath();
        File directory = new File(uploadDir);
        if (!directory.exists()) {
            boolean created = directory.mkdirs();
            if (!created) {
                throw new ErrorException("Não foi possível criar o diretório: " + uploadDir);
            }
        }

        String uploadDirPaciente = new File("src/main/resources/static/public/" + empresa.get().getId() + "/" + pacienteId).getAbsolutePath();
        File directoryPaciente = new File(uploadDirPaciente);
        if (!directoryPaciente.exists()) {
            boolean created = directoryPaciente.mkdirs();
            if (!created) {
                throw new ErrorException("Não foi possível criar o diretório: " + uploadDirPaciente);
            }
        }

        LocalDate hoje = LocalDate.now();
        String uploadDirAtendimentoData = new File("src/main/resources/static/public/" + empresa.get().getId() + "/" + pacienteId + "/" + hoje).getAbsolutePath();
        File directoryAtendimentoData = new File(uploadDirAtendimentoData);
        if (!directoryAtendimentoData.exists()) {
            boolean created = directoryAtendimentoData.mkdirs();
            if (!created) {
                throw new ErrorException("Não foi possível criar o diretório: " + directoryAtendimentoData);
            }
        }

        for(MultipartFile file : files){
            File destino = new File(directoryAtendimentoData, file.getOriginalFilename());
            Files.write(destino, file.getBytes());
        }

    }
}
