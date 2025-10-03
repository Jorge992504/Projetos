package jabpdev.nahora.api.service;

import jabpdev.nahora.api.dto.response.PromocoesDtoResponse;
import jabpdev.nahora.api.repositorios.PromocoesRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
public class PromocoesGeraisService {
    private final PromocoesRepository promocoesRepository;
    private static final String url = "http://172.16.251.22:6060/api/public/";

    public List<PromocoesDtoResponse> buscaPromocoesGerais(){
        List<PromocoesDtoResponse> response = promocoesRepository.findByAtivo();
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
