package com.compras.api.api.repository.nfe;

import com.compras.api.api.dto.response.ResponseGastosItemDto;
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

    @Query("SELECT new com.compras.api.api.dto.response.ResponseGastosItemDto(" +
            "n.descricao, n.unit, n.qtde, n.un, n.vlTotal) " +
            "FROM Nfe n " +
            "WHERE n.user_id = :userId " +
            "AND FUNCTION('MONTH', n.dataTime) = :mes " +
            "AND FUNCTION('YEAR', n.dataTime) = :ano")
    List<ResponseGastosItemDto> findItensByMesAno(Long userId, int mes, int ano);


}
