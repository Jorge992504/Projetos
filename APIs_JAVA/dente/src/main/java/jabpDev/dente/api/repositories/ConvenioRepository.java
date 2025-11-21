package jabpDev.dente.api.repositories;


import jabpDev.dente.api.dto.response.ListarConvenioResponse;
import jabpDev.dente.api.entitys.Convenio;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ConvenioRepository extends JpaRepository<Convenio, Long> {

    List<Convenio> findByEmpresaId(Long empresaId);

    Optional<Convenio> findByIdAndEmpresaId(Long id, Long empresaId);
}
