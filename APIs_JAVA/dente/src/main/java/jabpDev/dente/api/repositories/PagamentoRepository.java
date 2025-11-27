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
            select p.*
            from pagamento p
            where p.empresa_id = :empresaId
            ORDER BY p.data_pagamento ASC;
            """,nativeQuery = true)
    List<Pagamento> findAllByEmpresaId(Long empresaId);
}
