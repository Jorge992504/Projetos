package com.compras.api.services;


import com.compras.api.api.dto.response.ResponseNfeProdutoDto;
import com.compras.api.api.models.NfeProduto;
import com.compras.api.api.models.Users;
import com.compras.api.api.repository.NfeProdutoRepository;
import com.compras.api.services.user.ServiceUser;
import lombok.RequiredArgsConstructor;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor //cria o constructor
public class NfeService {
    private final NfeProdutoRepository nfeProdutoRepository;
    private final ServiceUser serviceUser;



    public List<ResponseNfeProdutoDto> importarProdutos(String url)throws IOException {
        List<NfeProduto> entities = new ArrayList<>();
        List<ResponseNfeProdutoDto> dtos = new ArrayList<>();
        Users u = (Users) SecurityContextHolder.getContext().getAuthentication().getPrincipal(); //contexto para pegar o email do token
        Optional<Users> user = serviceUser.getUser(u.getEmail());

        Document doc = Jsoup.connect(url).get();

        Elements linhas  =doc.select("#tabResult tr");

        for (Element linha : linhas) {
            String descricao = linha.select("span.txtTit").text().trim();
            if (descricao.isEmpty()) continue;

            String qtdeRaw = linha.select("span.Rqtd").text();
            String unRaw   = linha.select("span.RUN").text();
            String unitRaw = linha.select("span.RvlUnit").text();

            int qtde     = parseIntPtBr(qtdeRaw);
            String un    = extractUN(unRaw);
            float unit   = parseFloatPtBr(unitRaw);

            // entidade para persistir
            NfeProduto entity = NfeProduto.builder()
                    .user_id(user.get().getId())
                    .descricao(descricao)
                    .qtde(qtde)
                    .un(un)
                    .unit(unit)
                    .build();
            entities.add(entity);

            // DTO para retorno
            dtos.add(new ResponseNfeProdutoDto(descricao, un, qtde, unit));
        }

        nfeProdutoRepository.saveAll(entities);
        return dtos;
    }

    private int parseIntPtBr(String raw) {
        String cleaned = raw.replace("Qtde", "")
                .replace("Qtde.:", "")
                .replaceAll("[^0-9,.,,]", "")
                .replace(".", "")
                .replace(",", ".");
        if (cleaned.isEmpty()) return 0;
        return (int) Math.round(Double.parseDouble(cleaned));
    }

    private float parseFloatPtBr(String raw) {
        String cleaned = raw.replace("Vl. Unit.:", "")
                .replace("R$", "")
                .replaceAll("[^0-9,.,,]", "")
                .replace(".", "")
                .replace(",", ".");
        if (cleaned.isEmpty()) return 0f;
        return Float.parseFloat(cleaned);
    }

    private String extractUN(String raw) {
        return raw.replace("UN:", "").trim();
    }
}
