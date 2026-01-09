package jabpDev.ServicosPro.api.Controllers.Geral;

import jabpDev.ServicosPro.api.Dto.Request.RequestCategorias;
import jabpDev.ServicosPro.api.Dto.Response.ResponseCategorias;
import jabpDev.ServicosPro.api.Repositorys.RepositoryCategorias;
import jabpDev.ServicosPro.api.Services.Geral.ServicesCategorias;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.List;

@RestController
@AllArgsConstructor
@RequestMapping("/categorias")
public class ControllerCategorias {
    private final ServicesCategorias servicesCategorias;

    @PostMapping("/registrar")
    public ResponseEntity<String> registrarCategorias(@RequestBody List<RequestCategorias> categoriasList)throws IOException {
        return ResponseEntity.ok(String.valueOf(servicesCategorias.registrarCategorias(categoriasList)));
    }

    @GetMapping("/buscar")
    public List<ResponseCategorias> buscarCategorias(){
        return servicesCategorias.buscarCategorias();
    }

}
