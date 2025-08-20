package com.compras.api.controller.dashboard;


import com.compras.api.api.dto.response.ResponseGastosDto;
import com.compras.api.services.dashboard.DashBoardService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/dashboard")
@RequiredArgsConstructor
public class DashBoardController {

    private final DashBoardService dashBoardService;

    @GetMapping("/gastos")
    public List<ResponseGastosDto> getTotais(){
        return dashBoardService.listarVlTotal();
    }
}
