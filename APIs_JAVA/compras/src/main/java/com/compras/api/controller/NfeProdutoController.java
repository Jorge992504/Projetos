package com.compras.api.controller;


import com.compras.api.api.dto.response.ResponseNfeProdutoDto;
import com.compras.api.api.exception.ErrorException;
import com.compras.api.services.NfeService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;
import java.util.List;

@RestController
@RequestMapping("/nfe")
public class NfeProdutoController {

    private final NfeService nfeService;

    public NfeProdutoController(NfeService nfeService) {
        this.nfeService = nfeService;
    }

    @PostMapping
    public ResponseEntity<List<ResponseNfeProdutoDto>> importar(@RequestParam String url){
        try {
            return ResponseEntity.ok(nfeService.importarProdutos(url));
        }catch (IOException e){
            throw new ErrorException("Erro ao gravar preçoes", 401,e.getMessage());
        }
    }
}
