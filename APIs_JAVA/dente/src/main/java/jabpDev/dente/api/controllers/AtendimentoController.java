package jabpDev.dente.api.controllers;


import jabpDev.dente.api.services.AtendimentoService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

@RestController
@AllArgsConstructor

@RequestMapping("/atendimento")
public class AtendimentoController {

    private final AtendimentoService atendimentoService;

    @PostMapping(path = "/finalizar",consumes = {"multipart/form-data"})
    public void finalizarAtendimento(@RequestParam("files")MultipartFile[] files,
                                     @RequestParam("atendimento") String atendimento,
                                     @RequestParam("agendamentoId") Long agendamentoId,
                                     @RequestParam("pacienteId") Long pacienteId){
        atendimentoService.finalizarAtendimento(files, atendimento, agendamentoId,pacienteId);
    }
}
