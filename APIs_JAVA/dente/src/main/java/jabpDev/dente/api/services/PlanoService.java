package jabpDev.dente.api.services;

import com.mercadopago.MercadoPagoConfig;
import com.mercadopago.client.common.IdentificationRequest;
import com.mercadopago.client.payment.PaymentClient;
import com.mercadopago.client.payment.PaymentCreateRequest;
import com.mercadopago.client.payment.PaymentPayerRequest;
import com.mercadopago.core.MPRequestOptions;
import com.mercadopago.exceptions.MPApiException;
import com.mercadopago.exceptions.MPException;
import com.mercadopago.resources.payment.Payment;
import jabpDev.dente.api.dto.request.CardRequest;
import jabpDev.dente.api.dto.request.PixRequest;
import jabpDev.dente.api.dto.response.*;
import jabpDev.dente.api.entitys.Empresa;
import jabpDev.dente.api.entitys.Plano;
import jabpDev.dente.api.exceptions.ErrorException;
import jabpDev.dente.api.repositories.EmpresaRepository;
import jabpDev.dente.api.repositories.PlanoRepository;
import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.*;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@Service
@AllArgsConstructor
public class PlanoService {

    private final PlanoRepository planoRepository;
    private final EmpresaRepository empresaRepository;
    private final ServicesGerais servicesGerais;

    @Transactional
    public String verificaPlano(){

        String nmEmpresa =  SecurityContextHolder.getContext().getAuthentication().getName();
        Optional<Empresa> empresa = empresaRepository.findByEmailClinica(nmEmpresa);
        if (empresa.isEmpty()){
            throw new ErrorException("Realizar login novamente");
        }

        Optional<Plano> plano = planoRepository.findByEmpresaId(empresa.get().getId());
        LocalDate dataAtual = LocalDate.now();
        if (plano.get().getPeriodoTeste()){
            if (!dataAtual.isAfter(plano.get().getDataTeste().plusDays(30))){
                return "Teste";
            }else{
                Plano planoAtualizar = plano.get();
                planoAtualizar.setPeriodoTeste(false);
                planoRepository.save(planoAtualizar);
                return "!Teste";
            }
        }else if (plano.get().getPlano()){
            String periodo = plano.get().getPeriodo();
            if (periodo.equals("Mensal")){
                if (!dataAtual.isAfter(plano.get().getDataInicio().plusDays(30))){
                    return "Plano";
                }else{
                    Plano planoAtualizar = plano.get();
                    planoAtualizar.setPlano(false);
                    planoRepository.save(planoAtualizar);
                    return "Finalizado";
                }
            }else if(periodo.equals("Semestral")){
                LocalDate fimSemestre = plano.get().getDataInicio().plusDays(180);
                if (!dataAtual.isAfter(fimSemestre)) {
                    return "Plano";
                } else {
                    Plano planoAtualizar = plano.get();
                    planoAtualizar.setPlano(false);
                    planoRepository.save(planoAtualizar);
                    return "Finalizado";
                }
            }else if(periodo.equals("Anual")){
                LocalDate fimAno = plano.get().getDataInicio().plusDays(365);

                if (!dataAtual.isAfter(fimAno)) {
                    return "Plano";
                } else {
                    Plano planoAtualizar = plano.get();
                    planoAtualizar.setPlano(false);
                    planoRepository.save(planoAtualizar);
                    return "Finalizado";
                }
            }
        }
        return "!Plano";
    }

    @Transactional
    private void assinarPlano(){
        String nmEmpresa =  SecurityContextHolder.getContext().getAuthentication().getName();
        Optional<Empresa> empresa = empresaRepository.findByEmailClinica(nmEmpresa);
        if (empresa.isEmpty()){
            throw new ErrorException("Realizar login novamente");
        }
    }

//    PIX
    public PixResponse pagarPix(PixRequest body) throws MPException, MPApiException {
        try {

            MercadoPagoConfig.setAccessToken(servicesGerais.accessToken);
            String idempotencyKey = "pix_" + System.currentTimeMillis();

            Map<String,String> customHeaders = new HashMap<>();
            customHeaders.put("x-idempotency-key", idempotencyKey);

            MPRequestOptions mpRequestOptions = MPRequestOptions.builder()
                    .customHeaders(customHeaders)
                    .build();

            PaymentClient paymentClient = new PaymentClient();

            PaymentCreateRequest paymentCreateRequest = PaymentCreateRequest.builder()
                    .transactionAmount(new BigDecimal(String.valueOf(body.valor())))
                    .description(body.descricao())
                    .paymentMethodId("pix")
                    .dateOfExpiration(OffsetDateTime.now(ZoneOffset.of("-03:00")).plusMinutes(30))
                    .payer(
                            PaymentPayerRequest.builder()
                                    .email(body.email())
                                    .firstName(body.name())
                                    .identification(
                                            IdentificationRequest.builder()
                                                    .type("CPF")
                                                    .number("80233616942")
                                    .build()
                                    )
                                    .build()
                    )
                    .build();

            Payment payment = paymentClient.create(paymentCreateRequest,mpRequestOptions);

            return new PixResponse(
                    payment.getPointOfInteraction()
                            .getTransactionData()
                            .getQrCode(),
                    payment.getPointOfInteraction()
                            .getTransactionData()
                            .getQrCodeBase64(),
                    payment.getId()
            );
        }catch (MPException e){
            throw new ErrorException("MPException, erro no mp: " + e.getMessage());
        }catch (MPApiException e){
            throw new ErrorException("MPApiException, erro na api: " + e.getMessage() + " \n " + "Status: " + e.getApiResponse().getStatusCode() + " \n " + "Content: " + e.getApiResponse().getContent());
        }
    }

    public PixStatusResponse statusPix(Long paymentId){
        try {
            MercadoPagoConfig.setAccessToken(servicesGerais.accessToken);
            PaymentClient paymentClient = new PaymentClient();
            Payment payment = paymentClient.get(paymentId);
            return new PixStatusResponse(payment.getStatus());
        }catch (MPException e){
            throw new ErrorException("MPException, erro no mp: " + e.getMessage());
        }catch (MPApiException e){
            throw new ErrorException("MPApiException, erro na api: " + e.getMessage() + " \n " + "Status: " + e.getApiResponse().getStatusCode() + " \n " + "Content: " + e.getApiResponse().getContent());
        }

    }

//    pagamento com cartao
    public PublicKeyResponse getPublicKey(){
        return new PublicKeyResponse(servicesGerais.publicKey);
    }

    public CardResponse pagarCartao(CardRequest body) throws MPException, MPApiException {
        try {
            MercadoPagoConfig.setAccessToken(servicesGerais.accessToken);
            String idempotencyKey = "card_" + System.currentTimeMillis();

            Map<String, String> customHeaders = new HashMap<>();
            customHeaders.put("x-idempotency-key", idempotencyKey);

            MPRequestOptions mpRequestOptions = MPRequestOptions.builder()
                    .customHeaders(customHeaders)
                    .build();

            PaymentClient paymentClient = new PaymentClient();

            PaymentCreateRequest paymentCreateRequest = PaymentCreateRequest.builder()
                    .transactionAmount(body.amount())
                    .token(body.cardToken())
                    .description(body.descricao())
                    .installments(body.parcelas())
                    .paymentMethodId(body.paymentMethodId())
                    .payer(
                            PaymentPayerRequest.builder()
                                    .email(body.email())
                                    .firstName(body.name())
                                    .identification(
                                            IdentificationRequest.builder()
                                                    .type("CPF")
                                                    .number(body.cpf())
                                                    .build()
                                    )
                                    .build()
                    )
                    .build();

            Payment payment = paymentClient.create(paymentCreateRequest,mpRequestOptions);
            return new CardResponse(
                    payment.getStatus(),
                    payment.getStatusDetail(),
                    payment.getId(),
                    payment.getDateApproved(),
                    payment.getPaymentMethodId(),
                    payment.getPaymentTypeId()
            );
        }catch (MPException e){
            throw new ErrorException("MPException, erro no mp: " + e.getMessage());
        }catch (MPApiException e){
            throw new ErrorException("MPApiException, erro na api: " + e.getMessage() + " \n " + "Status: " + e.getApiResponse().getStatusCode() + " \n " + "Content: " + e.getApiResponse().getContent());
        }
    }

    public CardStatusResponse statusCard(Long paymentId) throws MPException, MPApiException {
        try {
            MercadoPagoConfig.setAccessToken(servicesGerais.accessToken);
            PaymentClient paymentClient = new PaymentClient();
            Payment payment = paymentClient.get(paymentId);
            return new CardStatusResponse(payment.getStatus());
        }catch (MPException e){
            throw new ErrorException("MPException, erro no mp: " + e.getMessage());
        }catch (MPApiException e){
            throw new ErrorException("MPApiException, erro na api: " + e.getMessage() + " \n " + "Status: " + e.getApiResponse().getStatusCode() + " \n " + "Content: " + e.getApiResponse().getContent());
        }
    }
}




