package jabpDev.dente.api.repositories;

import jabpDev.dente.api.entitys.Empresa;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface EmpresaRepository extends JpaRepository<Empresa, Long> {
    Optional<Empresa> findByEmailClinica(String email);
}
