package com.payments.api.controllers;

import com.payments.api.customexception.CustomException;
import com.payments.api.models.Produto;
import com.payments.api.services.NfService;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

@RestController
@RequestMapping("/nfe")
public class NfController {
    private final NfService nfService;

    public NfController(NfService nfService) {
        this.nfService = nfService;
    }

    @PostMapping
    public ResponseEntity<?> uploadPdf(@RequestParam MultipartFile arquivo) throws IOException {
        if (arquivo.isEmpty()) {
            throw new CustomException(401, "OBJECT_IS_EMPTY", "Arquivo vazio");
        }
        nfService.processarPdf(arquivo);
        return ResponseEntity.status(200).build();
    }
}
