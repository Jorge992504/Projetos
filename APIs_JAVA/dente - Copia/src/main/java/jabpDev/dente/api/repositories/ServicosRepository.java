package jabpDev.dente.api.repositories;

import jabpDev.dente.api.dto.response.BuscarServicosDtoResponse;
import jabpDev.dente.api.entitys.Servicos;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;


@Repository
public interface ServicosRepository extends JpaRepository<Servicos, Long> {


    List<BuscarServicosDtoResponse> findByEmpresaId(Long empresaId);

    Optional<Servicos> findByIdAndEmpresaId (Long id, Long empresaId);
}
