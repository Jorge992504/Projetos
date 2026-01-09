package jabpDev.ServicosPro.api.Repositorys;

import jabpDev.ServicosPro.api.Entitys.Categorias;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;


@Repository
public interface RepositoryCategorias extends JpaRepository<Categorias,Long> {
    List<Categorias> findAll();

    @Override
    Optional<Categorias> findById(Long id);
}
