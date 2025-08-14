package com.compras.api.api.repository.select_products;

import com.compras.api.api.models.Select_Products;
import com.compras.api.api.models.Users;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface SelectProductsRespository extends JpaRepository<Select_Products,Long> {
    List<Long> findByUserId(Long userId);
    boolean existsByUserIdAndProductId(Long userId, Long productId);

    @Modifying
    @Transactional
    @Query("DELETE FROM Select_Products sp WHERE sp.user_id = :userId AND sp.product_id = :productId")
    void deleteByUserIdAndProductId(@Param("userId") Long userId, @Param("productId") Long productId);

}
