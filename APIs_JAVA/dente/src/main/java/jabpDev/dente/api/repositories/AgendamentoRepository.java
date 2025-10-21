package jabpDev.dente.api.repositories;

import jabpDev.dente.api.dto.response.AgendamentosDtoResponse;
import jabpDev.dente.api.entitys.Agendamento;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
public interface AgendamentoRepository extends JpaRepository<Agendamento, Long> {
    List<AgendamentosDtoResponse> findByEmpresaId(Long empresaId);

}
