package com.payments.api.repositorys;

import com.payments.api.models.Produto;
import com.payments.api.models.Users;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface ProdutoRepository extends JpaRepository<Produto,Long> {
    List<Produto> findAll();
}
