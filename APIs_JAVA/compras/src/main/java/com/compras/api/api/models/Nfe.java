package com.compras.api.api.models;


import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.Date;

@Entity
@Table
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Nfe {


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // Relacionamento com Users
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", insertable = false, updatable = false)
    private Users user;

    @Column(nullable = false)
    private Long user_id;

    @Column(nullable = false)
    private LocalDateTime dataTime;

    private float unit;
    private String un;
    private String descricao;
    private int qtde;
    private String empresa;
    private float vlTotal;

}
