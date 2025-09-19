package jabp.chat.api.controller;


import jabp.chat.api.dto.request.LoginDtoRequest;
import jabp.chat.api.dto.response.TokenDtoResponse;
import jabp.chat.api.exceptions.ErrorException;
import jabp.chat.api.services.LoginService;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@AllArgsConstructor
public class LoginController {
    private final LoginService loginService;

    public TokenDtoResponse login(@RequestParam LoginDtoRequest loginDtoRequest){
        if (loginDtoRequest.email().isEmpty()){
            throw new ErrorException("Usuário não informado");
        }else if ( loginDtoRequest.password().isEmpty()){
            throw new ErrorException("Senha não informada");
        }else{
            return new TokenDtoResponse(loginService.login(loginDtoRequest.email(), loginDtoRequest.password()));
        }

    }
}
