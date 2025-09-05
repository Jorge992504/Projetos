package com.compras.api.services.nfe;


import com.compras.api.api.dto.response.ResponseNfeDto;
import com.compras.api.api.models.Nfe;
import com.compras.api.api.models.Users;
import com.compras.api.api.repository.nfe.NfeRepository;
import com.compras.api.services.user.ServiceUser;
import lombok.RequiredArgsConstructor;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
@RequiredArgsConstructor //cria o constructor
public class NfeService {


    private final NfeRepository nfeRepository;
    private final ServiceUser serviceUser;


    public List<ResponseNfeDto> importarProdutos(String url, String empresa)throws IOException {
        List<Nfe> produtos = new ArrayList<>();
        List<ResponseNfeDto> dtos = new ArrayList<>();
        Users u = (Users) SecurityContextHolder.getContext().getAuthentication().getPrincipal(); //contexto para pegar o email do token
        Optional<Users> user = serviceUser.getUser(u.getEmail());

        Document doc = Jsoup.connect(url).get();

        Elements linhas = doc.select("#tabResult tr");
        Elements info = doc.select("div#infos div:has(h4:contains(Informações gerais da Nota)) li");
        //Extrai cnpj
        String cnpjUrl = doc.select("div.text:matchesOwn(^\\s*CNPJ)").text().replace("CNPJ:", "").trim();

        //Extrair data e hora
        LocalDateTime dataTime = null;
        if (info != null){
            String texto = info.text();
            // Data de emissão
            String emissao = texto.split("Emissão:")[1].split("-")[0].trim();
            dataTime = parseDateTime(emissao);
        }

//        //Extrair valor pago
//        String valorPagoUrl = doc.select("#linhaTotal.linhaShade span.totalNumb").text().trim();
//        float valorPago = parseFloatPtBr(valorPagoUrl);

        for (Element linha : linhas) {
            String descricao = linha.select("span.txtTit").text().trim();
            if (descricao.isEmpty()) continue;

            String qtdeUrl = linha.select("span.Rqtd").text();
            String unUrl   = linha.select("span.RUN").text();
            String unitUrl = linha.select("span.RvlUnit").text();
            String vlTotalUrl = linha.select("span.valor").text();

            int qtde     = parseIntPtBr(qtdeUrl);
            String un    = extractUN(unUrl);
            float unit   = parseFloatPtBr(unitUrl);
            float vlTotal   = parseFloatPtBrVl(vlTotalUrl);

            // entidade para persistir
            Nfe produto = Nfe.builder()
                    .id(null)
                    .user_id(user.get().getId())
                    .descricao(descricao)
                    .qtde(qtde)
                    .un(un)
                    .unit(unit)
                    .dataTime(dataTime)
                    .vlTotal(vlTotal)
                    .empresa(empresa)
                    .build();
            produtos.add(produto);

            // DTO para retorno
            dtos.add(new ResponseNfeDto(dataTime,unit,un,descricao,qtde,empresa,vlTotal));
        }

        nfeRepository.saveAll(produtos);
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

    private float parseFloatPtBrVl(String raw) {
        String cleaned = raw.replace("Vl. Pago.:", "")
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

    private LocalDateTime parseDateTime(String raw){
        if (raw == null || raw.isEmpty()){
            return LocalDateTime.now();
        }else{
            DateTimeFormatter formatterWithoutMillis = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");
            LocalDateTime dateTime =  LocalDateTime.parse(raw, formatterWithoutMillis);
            if (dateTime == null){
                return LocalDateTime.now();
            }else{
                return dateTime;
            }
        }
    }
}
