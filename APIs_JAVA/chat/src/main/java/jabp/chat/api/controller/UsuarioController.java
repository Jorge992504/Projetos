package jabp.chat.api.controller;


import jabp.chat.api.dto.request.HistoricoMessagesDtoRequest;
import jabp.chat.api.dto.response.HistoricoMessagesDtoResponse;
import jabp.chat.api.dto.response.TokenDtoResponse;
import jabp.chat.api.dto.response.UsuarioDtoResponse;
import jabp.chat.api.entitys.Usuario;
import jabp.chat.api.services.UsuarioService;
import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@RestController
@RequiredArgsConstructor
@RequestMapping("/usuario")
public class UsuarioController {

    private final UsuarioService usuarioService;

    @GetMapping("/validateToken")
    public ResponseEntity<?> validateToken(@RequestParam String token) {
       boolean response = usuarioService.validarToken(token);
       return ResponseEntity.ok().build();
    }

    @GetMapping
    public UsuarioDtoResponse buscaUsuarioLogado(){
        Usuario usuario = (Usuario) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Optional<Usuario> usuarioOptional = usuarioService.buscaUsuario(usuario.getEmail());
        return new UsuarioDtoResponse(
                usuarioOptional.get().getEmail(),
                usuarioOptional.get().getName()
        );
    }
}
