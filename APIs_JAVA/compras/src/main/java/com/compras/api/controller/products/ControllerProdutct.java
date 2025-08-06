package com.compras.api.controller.products;


import com.compras.api.api.dto.response.ResponseProductsDto;
import com.compras.api.services.products.ServiceProducts;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/products")

public class ControllerProdutct {

    private final ServiceProducts serviceProducts;

    public ControllerProdutct(ServiceProducts serviceProducts){
        this.serviceProducts = serviceProducts;
    }

//    @GetMapping("/products")
    public ResponseEntity<List<ResponseProductsDto>> getAllProducts() {
        List<ResponseProductsDto> products = serviceProducts.getAllProducts();
        return ResponseEntity.ok(products);
    }


}
