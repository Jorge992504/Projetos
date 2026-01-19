package jabpDev.ServicosPro.api.Controllers.WebSocket;

import jabpDev.ServicosPro.api.Dto.Request.RequestMessageDto;
import jabpDev.ServicosPro.api.Dto.Response.ResponseFoto;
import jabpDev.ServicosPro.api.Dto.Response.ResponseMessageDto;
import jabpDev.ServicosPro.api.Entitys.Message;
import jabpDev.ServicosPro.api.Exceptions.CustomExeception.CustomException;
import jabpDev.ServicosPro.api.Services.WebSocket.ServiceMessage;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@AllArgsConstructor
@RequestMapping("/messages")
public class ControllerMessage {

    private ServiceMessage serviceMessage;

    @GetMapping("/buscar")
    public List<ResponseMessageDto> buscarMessages(@RequestParam Long usuarioTo){
        return serviceMessage.buscarMessages(usuarioTo);
    }

    @PostMapping("/salvar")
    public ResponseFoto salvarMessages(@RequestBody RequestMessageDto requestMessageDtos)throws Exception{
        try {
            return serviceMessage.salvarMessages(requestMessageDtos);
        }catch (Exception e){
            System.out.println("Não foi possível salvar as msg no banco: "+e.getMessage());
            throw new CustomException("Erro ao enviar mensagem");
        }
    }

}
