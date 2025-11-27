package mercado_pago.payment.controller;

import com.mercadopago.exceptions.MPApiException;
import com.mercadopago.exceptions.MPException;
import com.mercadopago.resources.payment.Payment;
import lombok.RequiredArgsConstructor;
import mercado_pago.payment.dto.*;
import mercado_pago.payment.service.PaymentService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.Map;
import java.util.Objects;

@RestController
@RequestMapping("/payment")
@RequiredArgsConstructor
public class PaymentController {

    private final PaymentService paymentService;

    @PostMapping("/pix")
    public PixResponse pagarPix(@RequestBody PixRequest request) throws MPException, MPApiException {
        return paymentService.pagarPix(request);
    }

    @GetMapping("/pix/status")
    public PixStatusResponse statusPix(@RequestParam Long paymentId){
        return paymentService.statusPix(paymentId);
    }

    @PostMapping("/card")
    public Payment pagarCartao(@RequestBody CardRequest request) throws MPException, MPApiException {
        return paymentService.pagarCartao(request);
    }
}
