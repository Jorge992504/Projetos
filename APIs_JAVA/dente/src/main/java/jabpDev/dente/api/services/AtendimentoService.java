package jabpDev.dente.api.services;


import jabpDev.dente.api.entitys.*;
import jabpDev.dente.api.exceptions.ErrorException;
import jabpDev.dente.api.repositories.*;
import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Date;
import java.util.Optional;

@Service
@AllArgsConstructor
public class AtendimentoService {
    private final AtendimentoRepository atendimentoRepository;
    private final AgendamentoRepository agendamentoRepository;
    private final EmpresaRepository empresaRepository;
    private final HistoricoRepository historicoRepository;
    private final PacienteRepository pacienteRepository;

    @Transactional
    public void finalizarAtendimento(MultipartFile[] files,String atendimento,Long agendamentoId,Long pacienteId){
        String nmEmpresa =  SecurityContextHolder.getContext().getAuthentication().getName();
        Optional<Empresa> empresa = empresaRepository.findByEmailClinica(nmEmpresa);
        if (empresa.isEmpty()){
            throw new ErrorException("Sem permissão para cadastrar dentista.\nRealizar login novamente");
        }

        Optional<Agendamento> agendamento = agendamentoRepository.findByIdAndEmpresaId(agendamentoId, empresa.get().getId());

        if (agendamento.isPresent()){
            Agendamento agendamento1 = agendamento.get();
            agendamento1.setStatus("Realizado");
            agendamentoRepository.save(agendamento1);
        }

        SimpleDateFormat formatoEntrada = new SimpleDateFormat("dd/MM/yyyy - HH:mm");
        Date dataConvertida = null;
        try {
            dataConvertida = formatoEntrada.parse(agendamento.get().getDataHora());
        } catch (ParseException e) {
            throw new RuntimeException(e);
        }
        SimpleDateFormat formatoSaida = new SimpleDateFormat("yyyy-MM-dd");
        String data = formatoSaida.format(dataConvertida);

        if (files != null){
            String uploadDir = new File("src/main/resources/static/public/" + empresa.get().getId()).getAbsolutePath();
            File directory = new File(uploadDir);
            if (!directory.exists()) {
                boolean created = directory.mkdirs();
                if (!created) {
                    throw new ErrorException("Não foi possível criar o diretório: " + uploadDir);
                }
            }

            String uploadDirPaciente = new File(uploadDir + "/" + pacienteId).getAbsolutePath();
            File directoryPaciente = new File(uploadDirPaciente);
            if (!directoryPaciente.exists()) {
                boolean created = directoryPaciente.mkdirs();
                if (!created) {
                    throw new ErrorException("Não foi possível criar o diretório: " + uploadDirPaciente);
                }
            }

            String uploadDirAtendimentoData = new File(uploadDirPaciente + "/" + data).getAbsolutePath();
            File directoryAtendimentoData = new File(uploadDirAtendimentoData);
            if (!directoryAtendimentoData.exists()) {
                boolean created = directoryAtendimentoData.mkdirs();
                if (!created) {
                    throw new ErrorException("Não foi possível criar o diretório: " + directoryAtendimentoData);
                }
            }

            for(MultipartFile file : files){
                File destino = new File(directoryAtendimentoData, file.getOriginalFilename());
                try {
                    Files.write(destino.toPath(), file.getBytes());
                } catch (IOException e) {
                    throw new ErrorException(e.toString());
                }
            }
        }

        Atendimento atendimento1 = Atendimento.builder()
                .atendimento(atendimento)
                .agendamento(agendamento.get())
                .empresa(empresa.get())
                .data(agendamento.get().getDataHora())
                .build();
        Atendimento atendimento2 = atendimentoRepository.save(atendimento1);
        if (atendimento2.getId() < 0 ){
            throw new ErrorException("Erro ao finalizar o atendimento");
        }

        Optional<Paciente> paciente = pacienteRepository.findByIdAndEmpresaId(pacienteId, empresa.get().getId());

        Historico historico = Historico.builder()
                .arquivo(pacienteId.toString())
                .atendimento(atendimento2)
                .data(data)
                .empresa(empresa.get())
                .paciente(paciente.get())
                .build();
        Historico response = historicoRepository.save(historico);
        if (response.getId() < 0 ){
            throw new ErrorException("Erro ao finalizar o atendimento");
        }
    }
}
