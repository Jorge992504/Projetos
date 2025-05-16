package com.api.aumigo.ApiAumigo.controller.user.auth;


import com.api.aumigo.ApiAumigo.dto.TokenDtoResponse;
import com.api.aumigo.ApiAumigo.exceptions.ErrorExeception;
import com.api.aumigo.ApiAumigo.exceptions.InvalidObjectException;
import com.api.aumigo.ApiAumigo.exceptions.ObjectEmptyException;
import com.api.aumigo.ApiAumigo.service.user.UserVerificationService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/verificaEmail")
public class UserVerificationController {
    private final UserVerificationService userVerificationService;

    public UserVerificationController(UserVerificationService userVerificationService) {
        this.userVerificationService = userVerificationService;
    }

    String token;

    @GetMapping
    public TokenDtoResponse verificaEmail(@RequestParam String email, @RequestParam int codigo) {
        if (email.isEmpty()) {
            throw new ObjectEmptyException("E-mail vazio");
        }

        try {
            token = userVerificationService.verificaEmail(email, codigo);
            if (token.isEmpty()) {
                throw new InvalidObjectException("Erro ao gerar token");
            }

            return new TokenDtoResponse("Usuário verificado com sucesso", token);
        } catch (Exception e) {
            throw new ErrorExeception(e);
        }
    }

}
