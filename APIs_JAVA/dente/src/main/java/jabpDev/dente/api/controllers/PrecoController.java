package jabpDev.dente.api.controllers;

import jabpDev.dente.api.dto.request.RegistrarPrecosDtoRequest;
import jabpDev.dente.api.services.PrecoService;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/preco")
@AllArgsConstructor
public class PrecoController {

    private final PrecoService precoService;

    @GetMapping("/find")
    public List<RegistrarPrecosDtoRequest> buscarPrecos(){
        return precoService.buscarPrecos();
    }

    @PostMapping("/save")
    public ResponseEntity<?> registrarPrecos(@RequestBody List<RegistrarPrecosDtoRequest> body){
        return precoService.registrarPrecos(body);
    }
}
