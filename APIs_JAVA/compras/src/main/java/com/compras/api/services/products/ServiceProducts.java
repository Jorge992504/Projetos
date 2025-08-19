package com.compras.api.services.products;


import com.compras.api.api.dto.response.ResponseProductsDto;
import com.compras.api.api.exception.ErrorException;
import com.compras.api.api.models.Products;
import com.compras.api.api.models.Select_Products;
import com.compras.api.api.models.Users;
import com.compras.api.api.repository.products.ProductsRepository;
import com.compras.api.api.repository.select_products.SelectProductsRespository;
import com.compras.api.services.user.ServiceUser;
import jakarta.transaction.Transactional;
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


    private static final String url = "http://172.20.10.7:8081/api/public/";

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

    @Transactional
    public void deleteProductFromUser(Long productId){
        Users u = (Users) SecurityContextHolder.getContext().getAuthentication().getPrincipal(); //contexto para pegar o email do token
        Optional<Users> user = serviceUser.getUser(u.getEmail());
        selectProductsRespository.deleteByUserIdAndProductId(user.get().getId(),productId);
    }

    @Transactional
    public void saveProductToUser(Long productId){
        Users u = (Users) SecurityContextHolder.getContext().getAuthentication().getPrincipal(); //contexto para pegar o email do token
        Optional<Users> user = serviceUser.getUser(u.getEmail());
        Optional<Products> products = productsRepository.findById(productId);
        if (selectProductsRespository.existsByUserIdAndProductId(user.get().getId(), productId)){
            throw new ErrorException("Produto já selecionado", 400,"PRODUCT_ALREADY_SELECTED");
        }
        Select_Products sp = Select_Products.builder().user_id(user.get().getId()).product_id(productId).build();
        selectProductsRespository.save(sp);
    }

    @Transactional
    public void saveProductToUserForName(String productName){
        Users u = (Users) SecurityContextHolder.getContext().getAuthentication().getPrincipal(); //contexto para pegar o email do token
        Optional<Users> user = serviceUser.getUser(u.getEmail());
        Optional<Products> products = productsRepository.findByName(productName);
        if (products.isPresent()){
            if (selectProductsRespository.existsByUserIdAndProductId(user.get().getId(), products.get().getId())){
                throw new ErrorException("Produto já selecionado", 400,"PRODUCT_ALREADY_SELECTED");
            }
            Select_Products sp = Select_Products.builder().user_id(user.get().getId()).product_id(products.get().getId()).build();
            selectProductsRespository.save(sp);
        }else{
            Products p = Products.builder().name(productName).foto("food.png").build();
            productsRepository.save(p);
            Optional<Products> Newproducts = productsRepository.findByName(productName);
            Select_Products sp = Select_Products.builder().user_id(user.get().getId()).product_id(Newproducts.get().getId()).build();
            selectProductsRespository.save(sp);
        }

    }
}
