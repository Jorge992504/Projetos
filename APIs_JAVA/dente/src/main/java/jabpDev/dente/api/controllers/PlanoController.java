package jabpDev.dente.api.controllers;


import com.mercadopago.exceptions.MPApiException;
import com.mercadopago.exceptions.MPException;
import jabpDev.dente.api.dto.request.CardRequest;
import jabpDev.dente.api.dto.request.PixRequest;
import jabpDev.dente.api.dto.response.*;
import jabpDev.dente.api.services.PlanoService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@AllArgsConstructor
@RequestMapping("/plano")
public class PlanoController {

    private final PlanoService planoService;

    @GetMapping("/status")
    public String verificaPlano(){
        return planoService.verificaPlano();
    }

//    buscar pix copia/cola e qrCode
    @PostMapping("/pix")
    public PixResponse pagarPix(@RequestBody PixRequest body) throws MPException, MPApiException {
        return planoService.pagarPix(body);
    }
    @GetMapping("/pix-status")
    public PixStatusResponse statusPix(@RequestParam Long paymentId, @RequestParam String token){
        return planoService.statusPix(paymentId,token);
    }

//    pagamento com cartoes
    @GetMapping("/public-key")
    public PublicKeyResponse getPublicKey(){
        return planoService.getPublicKey();
    }

    @PostMapping("/card")
    public CardResponse pagarCartao(@RequestBody CardRequest body) throws MPException, MPApiException {
        return planoService.pagarCartao(body);
    }

    @GetMapping("/card-status")
    public CardStatusResponse statusCard(@RequestParam Long paymentId,@RequestParam String token) throws MPException, MPApiException {
        System.out.println("paymentId: "+paymentId);
        return planoService.statusCard(paymentId,token);
    }
}
