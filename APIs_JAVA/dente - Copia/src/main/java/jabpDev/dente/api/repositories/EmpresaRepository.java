package jabpDev.dente.api.repositories;

import jabpDev.dente.api.entitys.Empresa;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface EmpresaRepository extends JpaRepository<Empresa, Long> {
    Optional<Empresa> findByEmailClinica(String email);
}
