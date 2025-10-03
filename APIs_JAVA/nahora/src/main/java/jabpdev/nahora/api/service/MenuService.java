package jabpdev.nahora.api.service;


import jabpdev.nahora.api.dto.response.ProdutoEspecificoDtoResponse;
import jabpdev.nahora.api.dto.response.PromocoesDtoResponse;
import jabpdev.nahora.api.exception.ErrorException;
import jabpdev.nahora.api.repositorios.ProdutoRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
public class MenuService {
    private final ProdutoRepository produtoRepository;
    private static final String url = "http://172.16.251.22:6060/api/public/";

    public List<ProdutoEspecificoDtoResponse> buscaProdutosEspecificos(Integer menu){
        if (menu == 0){
            throw new ErrorException("Erro ao buscar produtos dessa categoria");
        }else{
            List<ProdutoEspecificoDtoResponse> response = produtoRepository.findByCategoriaId(menu);
            return response.stream()
                    .map(p -> {
                        String image = url + p.produtoImage();
                        return new ProdutoEspecificoDtoResponse(
                                p.produtoId(),
                                image,
                                p.produtoNome(),
                                p.produtoQuantidade(),
                                p.produtoDescricao(),
                                p.produtoDescricaoQtde(),
                                p.precoVariacao()
                        );
                    }).collect(Collectors.toList());
        }
    }




    public List<PromocoesDtoResponse> buscaPromocoesEspecificas(Integer menu){
        if (menu == 0){
            throw new ErrorException("Erro ao buscar promoções dessa categoria");
        }else{
            List<PromocoesDtoResponse> response = produtoRepository.findByAtivoAndCategoriaId(menu);
            return response.stream()
                    .map(p -> {
                        String image = url + p.produtoImage();
                        return new PromocoesDtoResponse(
                                p.produtoId(),
                                image,
                                p.produtoNome(),
                                p.produtoAdicionalNome(),
                                p.produtoQuantidade(),
                                p.produtoDescricao(),
                                p.produtoAdicionalDescricaoQtde(),
                                p.produtoAdicionalQuantidade(),
                                p.produtoDescricaoQtde(),
                                p.promocaoId(),
                                p.produtoAdicionalId(),
                                p.precoPromocao(),
                                p.precoVariacao()
                        );
                    }).collect(Collectors.toList());
        }
    }
}


