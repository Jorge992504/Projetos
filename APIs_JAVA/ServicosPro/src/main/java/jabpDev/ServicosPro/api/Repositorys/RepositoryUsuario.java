package jabpDev.ServicosPro.api.Repositorys;


import jabpDev.ServicosPro.api.Entitys.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface RepositoryUsuario extends JpaRepository<Usuario,Long> {
    Optional<Usuario> findByEmail(String email);
}
