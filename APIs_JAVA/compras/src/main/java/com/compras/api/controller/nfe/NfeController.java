package com.compras.api.controller.nfe;


import com.compras.api.api.dto.response.ResponseNfeDto;
import com.compras.api.api.exception.ErrorException;
import com.compras.api.services.nfe.NfeService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;
import java.util.List;

@RestController
@RequestMapping("/nfe")
@RequiredArgsConstructor
public class NfeController {

    private final NfeService nfeService;

    @PostMapping
    public ResponseEntity<List<ResponseNfeDto>> nfe(@RequestParam String url, @RequestParam String empresa) throws IOException {
        if (url.isEmpty()){
            throw new ErrorException("Erro ao gravar preços");
        }else{
            return ResponseEntity.ok(nfeService.importarProdutos(url,empresa));

        }
    }
}
