package mercado_pago.payment.controller;

import com.mercadopago.exceptions.MPApiException;
import com.mercadopago.exceptions.MPException;
import lombok.RequiredArgsConstructor;
import mercado_pago.payment.dto.*;
import mercado_pago.payment.service.PaymentService;
import mercado_pago.payment.service.ServicesGerais;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.Base64;

@RestController
@RequestMapping("/payment")
@RequiredArgsConstructor
public class PaymentController {

    private final PaymentService paymentService;
    private final ServicesGerais servicesGerais;

    @PostMapping("/pix")
    public PixResponse pagarPix(@RequestBody PixRequest request) throws MPException, MPApiException {
        return paymentService.pagarPix(request);
    }

    @GetMapping("/pix/status")
    public PixStatusResponse statusPix(@RequestParam Long paymentId){
        return paymentService.statusPix(paymentId);
    }

    @GetMapping("/card")
    public String pagarCartao(@RequestParam String token) throws MPException, MPApiException {
        return paymentService.pagarCartao(token);
    }

    @GetMapping("/public-key")
    public ResponseEntity<String> getPublicKey(){
        String publicKey  = servicesGerais.getSecretKey();
        String base64 = Base64.getEncoder().encodeToString(publicKey.getBytes());
        return ResponseEntity.ok(base64);
    }
}
