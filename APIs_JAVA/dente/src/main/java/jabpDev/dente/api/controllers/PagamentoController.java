package jabpDev.dente.api.controllers;


import jabpDev.dente.api.dto.request.RegistrarPagamentoRequest;
import jabpDev.dente.api.dto.response.ListarConveniosResponse;
import jabpDev.dente.api.services.PagamentoService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@AllArgsConstructor
@RequestMapping("/pagamento")
public class PagamentoController {

    private final PagamentoService pagamentoService;

    @GetMapping("/busca/convenios")
    public List<ListarConveniosResponse> buscaConveniosPagamento(){
        return pagamentoService.buscaConveniosPagamento();
    }

    @PostMapping("/grava/pagamento")
    public void registrarPagamento(@RequestBody RegistrarPagamentoRequest body){
        pagamentoService.registrarPagamento(body);
    }
}
