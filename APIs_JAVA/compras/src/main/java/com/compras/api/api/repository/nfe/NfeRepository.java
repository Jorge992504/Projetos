package com.compras.api.api.repository.nfe;

import com.compras.api.api.models.Nfe;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface NfeRepository extends JpaRepository<Nfe, Long> {
    
    Optional<Nfe> findByUserId(Long userId);
}
