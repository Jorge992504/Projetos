package com.compras.api.api.repository.nfe;

import com.compras.api.api.models.Nfe;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;

public interface NfeRepository extends JpaRepository<Nfe, Long> {
    @Query("SELECT YEAR(i.data), MONTH(i.data), SUM(i.valor) " +
            "FROM Nfe i " +
            "WHERE i.userId = :userId " +
            "GROUP BY YEAR(i.data), MONTH(i.data) " +
            "ORDER BY YEAR(i.data), MONTH(i.data)")
    List<Object[]> somarPorMes(Long userId);
}
