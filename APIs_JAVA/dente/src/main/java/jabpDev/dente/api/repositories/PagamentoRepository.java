package jabpDev.dente.api.repositories;
import jabpDev.dente.api.entitys.Pagamento;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;


@Repository
public interface PagamentoRepository extends JpaRepository<Pagamento, Long> {

    Optional<Pagamento> findByAgendamentoId(Long agendamentoId);

    @Query(value = """
            select p.data_pagamento, SUM(valor_recebido)
            from pagamento p
            where p.status = 'Realizado'
            and p.empresa_id = :empresaId
            group by p.data_pagamento
            order by p.data_pagamento DESC
            """,nativeQuery = true)
    List<Object[]> faturamentoDiario(Long empresaId);
    @Query(value = """
            select s.nome, SUM(p.valor_recebido)
            from pagamento p
            JOIN agendamento a ON a.id = p.agendamento_id
            JOIN servicos s ON a.servico_id = s.id
            where p.status = 'Realizado'
            and p.empresa_id = :empresaId
            and p.data_pagamento = :data
            group by s.nome
            """,nativeQuery = true)
    List<Object[]> detalhesDiariosPorServico(Long empresaId, LocalDate data);
}
