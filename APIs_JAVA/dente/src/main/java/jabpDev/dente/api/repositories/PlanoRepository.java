package jabpDev.dente.api.repositories;

import jabpDev.dente.api.entitys.Plano;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface PlanoRepository extends JpaRepository<Plano, Long> {
    Optional<Plano> findByEmpresaId(Long empresaId);
}
