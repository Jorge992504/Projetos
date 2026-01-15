package jabpDev.ServicosPro.api.Repositorys;

import jabpDev.ServicosPro.api.Dto.Response.ResponseUsuarioPrestador;
import jabpDev.ServicosPro.api.Entitys.Usuario;
import jabpDev.ServicosPro.api.Entitys.UsuarioPrestador;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RepositoryUsuarioPrestador extends JpaRepository<UsuarioPrestador,Long> {
    @Query(value = """
             SELECT
                                              u.id AS usuarioId,
                                              u.nome AS usuarioNome,
                                              c.id AS categoriaId,
                                              c.nome AS categoriaNome,
                                              up.avaliacao
                                          FROM usuario_prestador up
                                          JOIN usuario u ON u.id = up.usuario
                                          JOIN categorias c ON c.id = up.categoria
                                          WHERE c.id = :idCategoria
            """, nativeQuery = true)
    List<ResponseUsuarioPrestador> findByCategoria(Long idCategoria);
}
