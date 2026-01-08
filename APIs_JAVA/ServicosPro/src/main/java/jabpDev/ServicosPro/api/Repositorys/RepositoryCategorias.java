package jabpDev.ServicosPro.api.Repositorys;

import jabpDev.ServicosPro.api.Entitys.Categorias;
import jabpDev.ServicosPro.api.Entitys.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


@Repository
public interface RepositoryCategorias extends JpaRepository<Categorias,Long> {
}
