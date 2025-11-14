package jabpDev.dente.api.repositories;


import jabpDev.dente.api.dto.response.ListaRelatoriosDtoResponse;
import jabpDev.dente.api.entitys.Relatorio;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RelatoriosRepository extends JpaRepository<Relatorio, Long> {

    @Query(
            value = """
                    SELECT
                    r.id,
                    r.descricao
                    FROM relatorio r
                    WHERE r.empresa_id = :empresaId or r.empresa_id = 0;
        """,
            nativeQuery = true
    )
    List<ListaRelatoriosDtoResponse> findByEmpresaId(Long empresaId);

}
