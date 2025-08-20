package com.compras.api.api.repository.nfe;

import com.compras.api.api.models.Nfe;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;

public interface NfeRepository extends JpaRepository<Nfe, Long> {
    @Query("SELECT YEAR(i.dataTime), MONTH(i.dataTime), SUM(i.vlTotal) " +
            "FROM Nfe i " +
            "WHERE i.user_id = :userId " +
            "GROUP BY YEAR(i.dataTime), MONTH(i.dataTime) " +
            "ORDER BY YEAR(i.dataTime), MONTH(i.dataTime)")
    List<Object[]> somarPorMes(Long userId);
}
