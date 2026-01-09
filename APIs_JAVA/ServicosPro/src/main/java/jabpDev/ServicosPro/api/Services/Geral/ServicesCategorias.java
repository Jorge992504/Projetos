package jabpDev.ServicosPro.api.Services.Geral;

import jabpDev.ServicosPro.api.Dto.Request.RequestCategorias;
import jabpDev.ServicosPro.api.Dto.Response.ResponseCategorias;
import jabpDev.ServicosPro.api.Entitys.Categorias;
import jabpDev.ServicosPro.api.Exceptions.CustomExeception.CustomException;
import jabpDev.ServicosPro.api.Repositorys.RepositoryCategorias;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Service
@AllArgsConstructor
public class ServicesCategorias {

    private final RepositoryCategorias repositoryCategorias;

    public ResponseEntity<String> registrarCategorias(List<RequestCategorias> categoriasList)throws IOException {
        try{
            List<Categorias> categorias = new ArrayList<>();
            for (RequestCategorias req : categoriasList) {
                Categorias categorias1 = new Categorias();
                categorias1.setId(req.id());
                categorias1.setNome(req.nome());
                categorias.add(categorias1);
            }
            repositoryCategorias.saveAll(categorias);
            return ResponseEntity.ok("Registradas com sucesso");
        }catch (Exception e){
            throw new CustomException("Erro ao registrar as categorias");
        }
    }

    public List<ResponseCategorias> buscarCategorias() {
        List<Categorias> categorias = repositoryCategorias.findAll();

        return categorias.stream()
                .map(cat -> new ResponseCategorias(
                        cat.getId(),
                        cat.getNome()
                ))
                .toList();
    }

}
