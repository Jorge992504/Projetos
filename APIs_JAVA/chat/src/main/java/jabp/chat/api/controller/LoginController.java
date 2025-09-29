package jabp.chat.api.controller;


import jabp.chat.api.dto.request.LoginDtoRequest;
import jabp.chat.api.dto.response.TokenDtoResponse;
import jabp.chat.api.exceptions.ErrorException;
import jabp.chat.api.services.LoginService;
import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/login")
public class LoginController {
    private final LoginService loginService;

    @PostMapping
    public ResponseEntity<TokenDtoResponse> login(@RequestBody LoginDtoRequest loginDtoRequest){
        if (loginDtoRequest.email().isEmpty()){
            throw new ErrorException("Usuário não informado");
        }else if ( loginDtoRequest.password().isEmpty()){
            throw new ErrorException("Senha não informada");
        }else{
            return ResponseEntity.ok(new TokenDtoResponse(loginService.login(loginDtoRequest.email(), loginDtoRequest.password())));
        }

    }
}
