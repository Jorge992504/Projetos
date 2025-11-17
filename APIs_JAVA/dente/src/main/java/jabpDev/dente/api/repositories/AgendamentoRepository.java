package jabpDev.dente.api.repositories;

import jabpDev.dente.api.dto.response.AgendamentoPorPacienteResponse;
import jabpDev.dente.api.dto.response.AgendamentosDtoResponse;
import jabpDev.dente.api.dto.response.HistoricoAgendamentosResponse;
import jabpDev.dente.api.entitys.Agendamento;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;


@Repository
public interface AgendamentoRepository extends JpaRepository<Agendamento, Long> {
    List<AgendamentosDtoResponse> findByEmpresaId(Long empresaId);


    @Query(
            value = """
                    SELECT\s
                        a.id,
                        a.status,
                        p.nome AS nome_paciente,
                        s.nome AS nome_servico,
                        a.data_hora,
                        a.observacoes,
                        a.paciente_id
                    FROM agendamento a
                    JOIN paciente p ON p.id = a.paciente_id
                    JOIN servicos s ON s.id = a.servico_id
                    WHERE a.empresa_id = :empresaId
                      AND a.id IN (:ids)
                      AND a.data_hora LIKE :data%;
        """,
            nativeQuery = true
    )
    List<AgendamentoPorPacienteResponse> findByEmpresaIdAndDataAndIds(
            @Param("empresaId") Long empresaId,
            @Param("ids") List<Long> ids,
            @Param("data") String data
    );


    Optional<Agendamento> findByIdAndEmpresaId(Long id, Long empresaId);


    @Query(
            value = """
                    SELECT
                    a.data_hora,
                    p.nome AS nome_paciente,
                    a.status,
                    s.nome AS servico,
                    at.atendimento
                    FROM agendamento a
                    LEFT JOIN paciente p ON p.id = a.paciente_id
                    LEFT JOIN servicos s ON s.id = a.servico_id
                    LEFT JOIN atendimento at ON a.id = at.agendamento_id
                    WHERE a.empresa_id = :empresaId
                      AND a.paciente_id = :pacienteId;
        """,
            nativeQuery = true
    )
    List<HistoricoAgendamentosResponse> findByPacienteIdAndEmpresaId(Long pacienteId, Long empresaId);


//query para buscar os dados dos relatorios---------------------------------------------------------------------
    @Query(value = """
        SELECT a.* FROM Agendamento a
        JOIN servicos s ON s.id = a.servico_id
        WHERE a.empresa_id = :empresaId
        AND a.status = 'Realizado'
        """, nativeQuery = true)
    List<Agendamento> findByEmpresaIdAndStatus(@Param("empresaId") Long empresaId);

    @Query(value = """
        SELECT a.* FROM Agendamento a
        JOIN servicos s ON s.id = a.servico_id
        WHERE a.empresa_id = :empresaId
        """, nativeQuery = true)
    List<Agendamento> findAllByEmpresa(@Param("empresaId") Long empresaId);

    @Query(value = """
            select * 
            from agendamento a
            where empresa_id = :empresaId
            order by data_hora ASC
            """, nativeQuery = true)
    List<Agendamento> buscaTodos(Long empresaId);


}
