package mercado_pago.payment.service;

import lombok.AllArgsConstructor;
import mercado_pago.payment.config.AESConfig;
import mercado_pago.payment.dto.PaymentDTO;
import org.json.JSONObject;
import org.springframework.stereotype.Service;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import java.nio.charset.StandardCharsets;
import java.security.KeyFactory;
import java.security.PrivateKey;
import java.security.spec.PKCS8EncodedKeySpec;
import java.util.Base64;

@Service
public class DecodificarService {

    private final AESConfig aesConfig;

    public DecodificarService(AESConfig aesConfig) {
        this.aesConfig = aesConfig;
    }

    public String decryptAES(String base64Criptografado) {
        try {
            String chave = aesConfig.getSecret(); // <-- pega a chave do properties

            SecretKeySpec secretKey = new SecretKeySpec(chave.getBytes(StandardCharsets.UTF_8), "AES");

            Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
            cipher.init(Cipher.DECRYPT_MODE, secretKey);

            byte[] bytesDecodificados = Base64.getDecoder().decode(base64Criptografado);
            byte[] textoDescriptografado = cipher.doFinal(bytesDecodificados);

            return new String(textoDescriptografado, StandardCharsets.UTF_8);

        } catch (Exception e) {
            throw new RuntimeException("Erro ao descriptografar AES: " + e.getMessage());
        }
    }

    public PaymentDTO parseCartao(String jsonDescriptografado) {


        JSONObject cartao = new JSONObject(jsonDescriptografado);

        return  new PaymentDTO(
        cartao.getString("cardNumber"),
        cartao.getString("securityCode"),
        cartao.getInt("expirationMonth"),
        cartao.getInt("expirationYear"),
        cartao.getString("cardholderName"),
        cartao.getString("cardholderCpf")
        );
    }
}
