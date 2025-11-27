package mercado_pago.payment.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
public class ServicesGerais {


    private final String token;

    public ServicesGerais(@Value("${mercadopago.access.token}") String token) {
        this.token = token;
    }

    public String returnAccessToken(){
        return token;
    }
}
