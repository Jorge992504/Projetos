package jabpDev.dente.api.repositories;

import jabpDev.dente.api.entitys.Preco;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PrecoRepository extends JpaRepository<Preco, Long> {

    @Override
    List<Preco> findAll();
}
