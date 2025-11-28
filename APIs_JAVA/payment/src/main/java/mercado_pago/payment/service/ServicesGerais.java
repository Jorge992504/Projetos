package mercado_pago.payment.service;

import lombok.Getter;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
public class ServicesGerais {


    private final String token;
    @Getter
    private final String secretKey;

    public ServicesGerais(@Value("${mercadopago.access.token}")String token,@Value("${aes.secret}") String secretKey ) {
        this.token = token;
        this.secretKey = secretKey;
    }

    public String returnAccessToken(){
        return token;
    }

}
