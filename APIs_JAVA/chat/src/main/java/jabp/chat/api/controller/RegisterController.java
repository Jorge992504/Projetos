package jabp.chat.api.controller;

import jabp.chat.api.dto.request.RegisterDtoRequest;
import jabp.chat.api.dto.response.TokenDtoResponse;
import jabp.chat.api.services.RegisterService;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@AllArgsConstructor
@RequestMapping("/register")
public class RegisterController {
    private final RegisterService registerService;

    @PostMapping
    public ResponseEntity<TokenDtoResponse> register(@RequestBody RegisterDtoRequest registerDtoRequest) {
        String token = registerService.register(registerDtoRequest);
        return ResponseEntity.ok(new TokenDtoResponse(token));
    }
}
