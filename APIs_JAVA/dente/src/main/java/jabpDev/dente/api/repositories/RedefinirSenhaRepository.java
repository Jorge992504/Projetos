package jabpDev.dente.api.repositories;

import jabpDev.dente.api.entitys.Password;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface RedefinirSenhaRepository extends JpaRepository<Password, Long> {
    Long findByEmpresaId(Long empresaId);
}
