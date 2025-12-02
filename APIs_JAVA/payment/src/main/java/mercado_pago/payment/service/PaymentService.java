package mercado_pago.payment.service;

import com.mercadopago.MercadoPagoConfig;
import com.mercadopago.client.cardtoken.CardTokenClient;
import com.mercadopago.client.common.IdentificationRequest;
import com.mercadopago.client.payment.PaymentClient;
import com.mercadopago.client.payment.PaymentCreateRequest;
import com.mercadopago.client.payment.PaymentPayerRequest;
import com.mercadopago.core.MPRequestOptions;
import com.mercadopago.exceptions.MPApiException;
import com.mercadopago.exceptions.MPException;
import com.mercadopago.resources.payment.Payment;
import lombok.AllArgsConstructor;
import mercado_pago.payment.dto.*;
import org.springframework.stereotype.Service;
import tools.jackson.databind.JsonNode;
import tools.jackson.databind.ObjectMapper;
import tools.jackson.databind.node.ObjectNode;

import java.math.BigDecimal;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.OffsetDateTime;
import java.time.ZoneOffset;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;

@Service
@AllArgsConstructor
public class PaymentService {

//    @Value("${mercadopago.access.token}")
//    private String accessToken;
//
//    @PostConstruct
//    public void init() {
//        MercadoPagoConfig.setAccessToken(accessToken);
//        System.out.println("MERCADO PAGO TOKEN CONFIGURADO!");
//    }

    private final ServicesGerais servicesGerais;

    // ----------------------------------------------------------
    // PIX
    // ----------------------------------------------------------
    public PixResponse pagarPix(PixRequest request) throws MPException, MPApiException {
        try{
            MercadoPagoConfig.setAccessToken("TEST-14621634747990-112615-22090bcbc47940b020eb33be105e7efc-1173608349");

            String idempotencyKey = "pix_" + System.currentTimeMillis();
            ZonedDateTime expiration = ZonedDateTime.now().plusDays(1);
            String dateOfExpiration = expiration.format(DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ssXXX"));


            Map<String,String> customHeaders = new HashMap<>();
            customHeaders.put("x-idempotency-key", idempotencyKey);

            MPRequestOptions requestOptions = MPRequestOptions.builder()
                    .customHeaders(customHeaders)
                    .build();

            PaymentClient client = new PaymentClient();

            PaymentCreateRequest paymentCreateRequest = PaymentCreateRequest.builder()
                    .transactionAmount(new BigDecimal(String.valueOf(request.valor())))
                    .description(request.descricao())
                    .paymentMethodId("pix")
                    .dateOfExpiration(OffsetDateTime.now(ZoneOffset.of("-03:00")).plusDays(1))
                    .payer(
                            PaymentPayerRequest.builder()
                                    .email("emailTeste@gmail.com")
                                    .firstName("Test")
                                    .identification(
                                            IdentificationRequest.builder().type("CPF").number("19119119100").build()
                                    )
                                    .build()
                    )
                    .build();
           Payment payment = client.create(paymentCreateRequest,requestOptions);
            return new PixResponse(
                   payment.getPointOfInteraction()
                           .getTransactionData()
                           .getQrCode(),
                   payment.getPointOfInteraction()
                           .getTransactionData()
                           .getQrCodeBase64(),
                   payment.getId()

           ) ;

        }catch (MPApiException e){
            System.out.println("==== ERRO MERCADO PAGO ====");
            System.out.println("Status: " + e.getApiResponse().getStatusCode());
            System.out.println("Content: " + e.getApiResponse().getContent());
            System.out.println("===========================");
            throw e;
        }
    }

    public PixStatusResponse statusPix(Long paymentId){
        MercadoPagoConfig.setAccessToken("TEST-14621634747990-112615-22090bcbc47940b020eb33be105e7efc-1173608349");
        PaymentClient client = new PaymentClient();
        try {
            Payment payment = client.get(paymentId);
            return new PixStatusResponse(payment.getStatus(), payment.getId());
        } catch (MPException e) {
            throw new RuntimeException(e);
        } catch (MPApiException e) {
            throw new RuntimeException(e);
        }
    }


    // ----------------------------------------------------------
    // CARTÃO
    // ----------------------------------------------------------
    public CardResponse pagarCartao(CardRequest cardRequest) throws MPException, MPApiException {
        try{
            MercadoPagoConfig.setAccessToken("TEST-14621634747990-112615-22090bcbc47940b020eb33be105e7efc-1173608349");
            String idempotencyKey = "card_" + System.currentTimeMillis();

            Map<String, String> customHeaders = new HashMap<>();
            customHeaders.put("x-idempotency-key", idempotencyKey);

            MPRequestOptions requestOptions = MPRequestOptions.builder()
                    .customHeaders(customHeaders)
                    .build();

            PaymentClient client = new PaymentClient();

            PaymentCreateRequest paymentCreateRequest =
                    PaymentCreateRequest.builder()
                            .transactionAmount(cardRequest.amount())
                            .token(cardRequest.cardToken())
                            .description(cardRequest.name())
                            .installments(cardRequest.parcelas())
                            .paymentMethodId(cardRequest.paymentMethodId())
                            .payer(
                                    PaymentPayerRequest.builder()
                                            .email("emailTeste@gmail.com")
                                            .firstName(cardRequest.name())
                                            .identification(
                                                    IdentificationRequest.builder()
                                                            .type("CPF")
                                                            .number("12345678909")
                                                            .build())
                                            .build())
                            .build();

            Payment response = client.create(paymentCreateRequest, requestOptions);
            return new CardResponse(
                    response.getStatus(),
                    response.getStatusDetail(),
                    response.getId(),
                    response.getDateApproved(),
                    response.getPaymentMethodId(),
                    response.getPaymentTypeId()

            );

        } catch (MPApiException e) {
            System.out.println("STATUS: " + e.getStatusCode());
            System.out.println("RESPONSE: " + e.getApiResponse().getContent());
            throw new RuntimeException(e);
        }
    }

    public CardStatusResponse statusCard(Long paymentId){
        MercadoPagoConfig.setAccessToken("TEST-14621634747990-112615-22090bcbc47940b020eb33be105e7efc-1173608349");
        PaymentClient client = new PaymentClient();
        try {
            Payment payment = client.get(paymentId);
            return new CardStatusResponse(payment.getStatus(), payment.getId());
        } catch (MPException e) {
            throw new RuntimeException(e);
        } catch (MPApiException e) {
            throw new RuntimeException(e);
        }
    }

}
