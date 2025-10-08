package jabpDev.dente.api.repositories;

import jabpDev.dente.api.entitys.Password;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface RedefinirSenhaRepository extends JpaRepository<Password, Long> {

    Optional<Password> findByCodigo(int codigo);
}
