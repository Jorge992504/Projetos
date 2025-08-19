package com.payments.api.services;


import com.payments.api.customexception.CustomException;
import com.payments.api.dto.response.ProdutoDto;
import com.payments.api.models.Produto;
import com.payments.api.repositorys.ProdutoRepository;
import jakarta.transaction.Transactional;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.text.PDFTextStripper;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class NfService {

    private final ProdutoRepository produtoRepository;

    public NfService(ProdutoRepository produtoRepository) {
        this.produtoRepository = produtoRepository;
    }

    @Transactional
    public boolean processarPdf(MultipartFile arquivo) throws IOException {

        List<ProdutoDto> produtos = new ArrayList<>();

        try (PDDocument documento = PDDocument.load(arquivo.getInputStream())) {
            PDFTextStripper stripper = new PDFTextStripper();
            String texto = stripper.getText(documento);

            String[] linhas = texto.split("\\r?\\n");

            for (String linha : linhas) {
                // Verifica se a linha contém os campos que queremos
                if (linha.contains("DESCRIAO") && linha.contains("QTDE")) {

                    Produto p = Produto.builder()
                            .name(extrairCampo(linha, "DESCRIAO"))
                            .quantidade(parseLong(extrairCampo(linha, "QTDE")))
                            .und(extrairCampo(linha, "UN"))
                            .vlUnd(parseFloat(extrairCampo(linha, "UNIT")))
                            .data(java.time.LocalDate.now())
                            .hora(java.time.LocalDateTime.now())
                            .build();

                    produtoRepository.save(p);
                }else{
                    throw new CustomException(401, "NOTA FISCAL SEM PRODUTOS", "Nota vazia");
                }
            }
            return true;
        }catch (Exception e){
            throw new CustomException(401, "Erro ao extrair PDF", e.getMessage());
        }


    }

    private String extrairCampo(String linha, String campo) {
        try {
            int index = linha.indexOf(campo) + campo.length() + 1; // pula ":" ou espaço
            String valor = linha.substring(index).trim();

            // Pega só até o próximo espaço ou tab, caso seja tabela
            int fim = valor.indexOf(" ");
            if (fim > 0) {
                valor = valor.substring(0, fim);
            }

            return valor;
        } catch (Exception e) {
            return "";
        }
    }


    private Long parseLong(String valor) {
        try {
            return Long.parseLong(valor.replace(",", "").trim());
        } catch (Exception e) {
            return 0L;
        }
    }

    private Float parseFloat(String valor) {
        try {
            return Float.parseFloat(valor.replace(",", ".").trim());
        } catch (Exception e) {
            return 0f;
        }
    }
}
