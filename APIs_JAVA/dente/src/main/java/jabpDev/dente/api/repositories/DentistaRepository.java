package jabpDev.dente.api.repositories;

import jabpDev.dente.api.dto.response.BuscaDentistasDtoResponse;
import jabpDev.dente.api.entitys.Dentista;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface DentistaRepository extends JpaRepository<Dentista, Long> {
    List<BuscaDentistasDtoResponse> findByEmpresaId(Long empresaId);

    Optional<Dentista> findByEmailAndEmpresaId(String email, Long empresaId);
}
