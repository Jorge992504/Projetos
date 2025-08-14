package com.compras.api.services.products;


import com.compras.api.api.dto.response.ResponseProductsDto;
import com.compras.api.api.models.Products;
import com.compras.api.api.models.Select_Products;
import com.compras.api.api.models.Users;
import com.compras.api.api.repository.products.ProductsRepository;
import com.compras.api.api.repository.select_products.SelectProductsRespository;
import com.compras.api.services.user.ServiceUser;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class ServiceProducts {

    private final ProductsRepository productsRepository;
    private final SelectProductsRespository selectProductsRespository;
    private final ServiceUser serviceUser;


    private static final String url = "http://172.16.251.22:8081/api/public/";

    public ServiceProducts(ProductsRepository productsRepository, SelectProductsRespository selectProductsRespository, ServiceUser serviceUser){
        this.productsRepository = productsRepository;
        this.selectProductsRespository = selectProductsRespository;
        this.serviceUser = serviceUser;
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

    public List<ResponseProductsDto> getProductsFromUser(){
        Users u = (Users) SecurityContextHolder.getContext().getAuthentication().getPrincipal(); //contexto para pegar o email do token
        Optional<Users> user = serviceUser.getUser(u.getEmail());
        return user.map(users -> users.getSelectedProducts()
                .stream()
                .map(Select_Products::getProduct) // pega o objeto Products
                .map(product -> {
                    String fotoUrl = (product.getFoto() != null && !product.getFoto().isEmpty())
                            ? url + product.getFoto()
                            : url + "food.png"; // fallback
                    return new ResponseProductsDto(
                            product.getId(),
                            product.getName(),
                            fotoUrl
                    );
                })
                .collect(Collectors.toList())).orElseGet(ArrayList::new);

    }
}
