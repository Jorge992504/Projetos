package jabpDev.dente.api.repositories;

import jabpDev.dente.api.entitys.Premium;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface PremiumRepository extends JpaRepository<Premium, Long> {
    Optional<Premium> findByEmpresaId(Long empresaId);
}
