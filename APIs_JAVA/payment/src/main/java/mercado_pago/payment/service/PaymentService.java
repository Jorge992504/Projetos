package mercado_pago.payment.service;

import com.mercadopago.MercadoPagoConfig;
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
    private final DecodificarService decodificarService;

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
    public String pagarCartao(String token) throws MPException, MPApiException {
        try{

            String json = decodificarService.decryptAES(token);
            PaymentDTO dados = decodificarService.parseCartao(json);

            String cardToken = gerarToken(dados);


//            MercadoPagoConfig.setAccessToken("TEST-14621634747990-112615-22090bcbc47940b020eb33be105e7efc-1173608349");
//            String idempotencyKey = "pix_" + System.currentTimeMillis();
//
//            Map<String, String> customHeaders = new HashMap<>();
//            customHeaders.put("x-idempotency-key", idempotencyKey);
//
//            MPRequestOptions requestOptions = MPRequestOptions.builder()
//                    .customHeaders(customHeaders)
//                    .build();
//
//            PaymentClient client = new PaymentClient();
//
//            PaymentCreateRequest paymentCreateRequest =
//                    PaymentCreateRequest.builder()
//                            .transactionAmount(request.amount())
//                            .token(request.token())
//                            .description(request.descricao())
//                            .installments(request.pacelas())
//                            .paymentMethodId(request.paymentMethodId())
//                            .payer(
//                                    PaymentPayerRequest.builder()
//                                            .email("emailTeste@gmail.com")
//                                            .firstName("Test")
//                                            .identification(
//                                                    IdentificationRequest.builder()
//                                                            .type("CPF")
//                                                            .number("12345678909")
//                                                            .build())
//                                            .build())
//                            .build();
//
//            return client.create(paymentCreateRequest, requestOptions);
            return cardToken;

        }catch (MPApiException e) {
            System.out.println("==== ERRO MERCADO PAGO ====");
            System.out.println("Status: " + e.getApiResponse().getStatusCode());
            System.out.println("Content: " + e.getApiResponse().getContent());
            System.out.println("===========================");
            throw e;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }


    public String gerarToken(PaymentDTO card) throws Exception {

        String url = "https://api.mercadopago.com/v1/card_tokens?public_key=" + "TEST-1842e064-25f7-44f4-84c9-58c47ae2dd25";

        ObjectMapper mapper = new ObjectMapper();

        ObjectNode cardHolder = mapper.createObjectNode();
        cardHolder.put("name", card.cardholderName());

        ObjectNode identification = mapper.createObjectNode();
        identification.put("type", "CPF");
        identification.put("number", card.cardholderCpf());

        cardHolder.set("identification", identification);

        ObjectNode body = mapper.createObjectNode();
        body.put("card_number", card.cardNumber());
        body.put("security_code", card.securityCode());
        body.put("expiration_month", card.expirationMonth());
        body.put("expiration_year", card.expirationYear());
        body.set("cardholder", cardHolder);

        HttpClient client = HttpClient.newHttpClient();

        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(url))
                .header("Content-Type", "application/json")
                .POST(HttpRequest.BodyPublishers.ofString(body.toString()))
                .build();

        HttpResponse<String> response =
                client.send(request, HttpResponse.BodyHandlers.ofString());

        JsonNode json = mapper.readTree(response.body());

        if (json.has("id")) {
            return json.get("id").asText(); // <-- este é o token!
        }

        throw new RuntimeException("Erro ao gerar token: " + json.toString());
    }








}
