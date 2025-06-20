package com.compras.api.api.repository.products;

import com.compras.api.api.models.Products;
import com.compras.api.api.models.Users;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface ProductsRepository extends JpaRepository<Products,Long> {
}
