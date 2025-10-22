package jabpDev.dente.api.repositories;

import jabpDev.dente.api.dto.response.AgendamentoPorPacienteResponse;
import jabpDev.dente.api.dto.response.AgendamentosDtoResponse;
import jabpDev.dente.api.entitys.Agendamento;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
public interface AgendamentoRepository extends JpaRepository<Agendamento, Long> {
    List<AgendamentosDtoResponse> findByEmpresaId(Long empresaId);


    @Query("""
        SELECT new com.jorge.ws.model.response.AgendamentoPorPacienteResponse(
            a.id,
            a.status,
            p.nome,
            s.nome,
            a.dataHora
        )
        FROM Agendamento a
        JOIN a.paciente p
        JOIN a.servico s
        WHERE a.empresa.id = :empresaId
          AND a.id IN :idsAgendamentos
          AND a.dataHora LIKE CONCAT(:dataFormatada, '%')
    """)
    List<AgendamentoPorPacienteResponse> findByEmpresaIdAndDataAndIds(
             Long empresaId,
             String dataFormatada,
             List<Long> idsAgendamentos
    );


}
