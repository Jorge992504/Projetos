package com.compras.api.services.products;


import com.compras.api.api.dto.response.ResponseProductsDto;
import com.compras.api.api.models.Products;
import com.compras.api.api.repository.products.ProductsRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class ServiceProducts {
    private final ProductsRepository productsRepository;
    private static final String url = "http://localhost:8081/public/";

    public ServiceProducts(ProductsRepository productsRepository){
        this.productsRepository = productsRepository;
    }

    public List<ResponseProductsDto> getAllProducts() {
        List<Products> products = productsRepository.findAll();
        return products.stream()
                .map(product -> {
                    String fotoUrl;
                    if (product.getFoto() != null && !product.getFoto().isEmpty()) {
                        fotoUrl = url + product.getFoto();
                    } else {
                        fotoUrl = url + "food.png";
                    }

                    return new ResponseProductsDto(
                            product.getId(),
                            product.getName(),
                            fotoUrl
                    );
                })
                .collect(Collectors.toList());
    }
}
