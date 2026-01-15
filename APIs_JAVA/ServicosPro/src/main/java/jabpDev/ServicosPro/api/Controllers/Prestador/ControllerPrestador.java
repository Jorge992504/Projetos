package jabpDev.ServicosPro.api.Controllers.Prestador;


import jabpDev.ServicosPro.api.Dto.Response.ResponseUsuarioPrestador;
import jabpDev.ServicosPro.api.Services.Prestador.ServicePrestador;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@AllArgsConstructor
@RequestMapping("/prestador")
public class ControllerPrestador {

    private ServicePrestador servicePrestador;

    @GetMapping("/buscar/categoria")
    public List<ResponseUsuarioPrestador> buscarPrestadorPorCategoria(@RequestParam Long categoriaId){
        return servicePrestador.buscarPrestadorPorCategoria(categoriaId);
    }
}
