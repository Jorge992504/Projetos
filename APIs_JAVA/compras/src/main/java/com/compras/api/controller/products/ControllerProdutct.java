package com.compras.api.controller.products;


import com.compras.api.api.dto.response.ResponseProductsDto;
import com.compras.api.api.exception.ErrorException;
import com.compras.api.services.products.ServiceProducts;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/products")

public class ControllerProdutct {

    private final ServiceProducts serviceProducts;

    public ControllerProdutct(ServiceProducts serviceProducts){
        this.serviceProducts = serviceProducts;
    }

    @GetMapping
    public ResponseEntity<List<ResponseProductsDto>> getAllProducts() {
        List<ResponseProductsDto> products = serviceProducts.getAllProducts();
        return ResponseEntity.ok(products);
    }

    @GetMapping("/user")
    public ResponseEntity<List<ResponseProductsDto>> getProductsFromUser(){
        List<ResponseProductsDto> productsFromUser = serviceProducts.getProductsFromUser();
        return ResponseEntity.ok(productsFromUser);
    }

    @DeleteMapping
    public void deleteProductFromUser(@RequestParam Long productId){
        if(productId != 0){
          serviceProducts.deleteProductFromUser(productId);
        }else{
            throw new ErrorException("Selecione o produto");
        }
    }

    @PostMapping
    public void saveProductToUser(@RequestParam Long productId){
        if(productId != 0){
            serviceProducts.saveProductToUser(productId);
        }else{
            throw new ErrorException("Selecione o produto");
        }
    }

    @PostMapping("/name")
    public void saveProductToUserForName(@RequestParam String productName){
        if(productName.isEmpty()){
            throw new ErrorException("Selecione o produto");
        }else{
            serviceProducts.saveProductToUserForName(productName);
        }
    }


}
