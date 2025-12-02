package jabpDev.dente.api.entitys;


import jakarta.persistence.*;
import lombok.*;

import java.math.BigDecimal;
import java.time.LocalDate;

@Entity
@Table
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Plano {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "empresa")
    private Empresa empresa;

    @Column(name = "plano")
    private Boolean plano;

    @Column(name = "tipo_plano")
    private String tipoPlano;
    @Column(name = "periodo")
    private String periodo;
    @Column(name = "data_inicio")
    private LocalDate dataInicio;

    @Column(name = "periodo_teste")
    private Boolean periodoTeste;
    @Column(name = "data_teste")
    private LocalDate dataTeste;


    @Column(name = "payment_type")
    private String paymentType;
    @Column(name = "paymentId")
    private Long paymentId;
    @Column(name = "payment_status")
    private String paymentStatus;
    @Column(name = "valor")
    private BigDecimal valor;
    @Column(name = "data_pagamento")
    private LocalDate dataPagamento;


}
