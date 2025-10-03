package jabpdev.nahora.api.controller;


import jabpdev.nahora.api.dto.response.ProdutoEspecificoDtoResponse;
import jabpdev.nahora.api.dto.response.PromocoesDtoResponse;
import jabpdev.nahora.api.service.MenuService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@AllArgsConstructor
@RequestMapping("/menu")
public class MenuController {
    private final MenuService menuService;

    @GetMapping
    public List<ProdutoEspecificoDtoResponse> buscaProdutosEspecificos(@RequestParam Integer menu){
        return menuService.buscaProdutosEspecificos(menu);
    }

    @GetMapping("/promocoes/especificas")
    public List<PromocoesDtoResponse> buscaPromocoesEspecificas(@RequestParam Integer menu){
        return menuService.buscaPromocoesEspecificas(menu);
    }
}
