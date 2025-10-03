package jabpdev.nahora.api.controller;


import jabpdev.nahora.api.dto.response.PromocoesDtoResponse;
import jabpdev.nahora.api.service.PromocoesGeraisService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;
import java.util.List;

@RestController
@AllArgsConstructor
@RequestMapping("/promocoes/gerais")
public class PromocoesGeraisController {

    private final PromocoesGeraisService promocoesGeraisService;

    @GetMapping
    public List<PromocoesDtoResponse> buscaPromocoesGerais(){
        return promocoesGeraisService.buscaPromocoesGerais();
    }
}
