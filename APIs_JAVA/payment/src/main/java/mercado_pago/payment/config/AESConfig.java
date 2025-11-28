package mercado_pago.payment.config;


import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;

@Configuration
public class AESConfig {

    @Value("${aes.secret}")
    private String secret;

    public String getSecret() {
        return secret;
    }
}
