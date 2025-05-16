package com.api.aumigo.ApiAumigo.models;


import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;
import java.util.Date;

@Entity
@Table
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Users {

    @Id
    @GeneratedValue (strategy = GenerationType.IDENTITY)
    private  Long id;

    private String name;

    @Column(nullable = false, unique = true)
    private String email;

    @Column(nullable = false)
    private String password;

    private String telefone;

    @Column(nullable = false)
    private String tipo;

    private LocalDate data;

    @Column(nullable = false)
    private int codigo;

    @Column(nullable = false)
    private Boolean verificado;
}

