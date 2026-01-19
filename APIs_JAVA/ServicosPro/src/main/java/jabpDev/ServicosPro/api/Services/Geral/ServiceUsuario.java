package jabpDev.ServicosPro.api.Services.Geral;

import jabpDev.ServicosPro.api.Dto.Response.ResponseUsuario;
import jabpDev.ServicosPro.api.Entitys.Categorias;
import jabpDev.ServicosPro.api.Entitys.Usuario;
import jabpDev.ServicosPro.api.Exceptions.CustomExeception.CustomException;
import jabpDev.ServicosPro.api.Repositorys.RepositoryCategorias;
import jabpDev.ServicosPro.api.Repositorys.RepositoryUsuario;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.Optional;

@Service
@AllArgsConstructor
public class ServiceUsuario {

    private RepositoryCategorias repositoryCategorias;
    private ServicosGeral servicosGeral;


    public ResponseUsuario buscarDadosUsuario(){
        Usuario usuario = servicosGeral.getUsuario();
        if (usuario.getTipoUsuario().equals("Cliente")){
            return new ResponseUsuario(
                    usuario.getId(),
                    usuario.getNome(),
                    usuario.getEmail(),
                    usuario.getFoto(),
                    usuario.getTipoUsuario(),
                    usuario.getTipoPessoa(),
                    usuario.getDataNascimento(),
                    usuario.getTelefone(),
                    usuario.getEndereco(),
                    0L,
                    "",
                    4.6,
                    127

            );
        }else{
            Optional<Categorias> categorias = repositoryCategorias.findById(usuario.getCategoriaPrestador().getId());
            return new ResponseUsuario(
                    usuario.getId(),
                    usuario.getNome(),
                    usuario.getEmail(),
                    usuario.getFoto(),
                    usuario.getTipoUsuario(),
                    usuario.getTipoPessoa(),
                    usuario.getDataNascimento(),
                    usuario.getTelefone(),
                    usuario.getEndereco(),
                    categorias.get().getId(),
                    categorias.get().getNome(),
                    4.6,
                    127
            );
        }

    }

}
