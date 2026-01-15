package jabpDev.ServicosPro.api.Services.Prestador;

import jabpDev.ServicosPro.api.Dto.Response.ResponseUsuarioPrestador;
import jabpDev.ServicosPro.api.Exceptions.CustomExeception.CustomException;
import jabpDev.ServicosPro.api.Repositorys.RepositoryUsuarioPrestador;
import jabpDev.ServicosPro.api.Services.Geral.ServicosGeral;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@AllArgsConstructor
public class ServicePrestador {

    private RepositoryUsuarioPrestador repositoryUsuarioPrestador;
    private ServicosGeral servicosGeral;

    public List<ResponseUsuarioPrestador> buscarPrestadorPorCategoria(Long categoriaId){
        if (categoriaId == 0){
            throw new CustomException("Categoria não encontrada");
        }
        return repositoryUsuarioPrestador.findByCategoria(categoriaId);
    }
}
