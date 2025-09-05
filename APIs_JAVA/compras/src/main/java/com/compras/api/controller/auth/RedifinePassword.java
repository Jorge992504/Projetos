package com.compras.api.controller.auth;


import com.compras.api.services.auth.RedefinePasswordService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/redefine")
public class RedifinePassword {
    private final RedefinePasswordService redefinePasswordService;

    @GetMapping
    public ResponseEntity<String> redefineSenha(@RequestParam String email, @RequestParam String password){
        redefinePasswordService.redefinirSenha(email,password);
        return ResponseEntity.ok("Senha redefinida com succeso, faza login novamnete");
    }
}
