package jabpDev.dente.api.entitys;


import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;

@Entity
@Table
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Pagamento {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "agendamento_id")
    private Agendamento agendamento;

    @ManyToOne
    @JoinColumn(name = "empresa_id")
    private Empresa empresa;

    @ManyToOne
    @JoinColumn(name = "dentista_id")
    private Dentista dentista;

    @ManyToOne
    @JoinColumn(name = "convenio_id")
    private Convenio convenio;

    @Column(name = "tipo_pagamento")
    private String tipo_pagamento;

    @Column(name = "status")
    private String status;

    @Column(name = "valor_cobrado")
    private Double valor_cobrado;

    @Column(name = "valor_atual")
    private Double valor_atual;

    @Column(name = "valor_desconto")
    private Double valor_desconto;

    @Column(name = "valor_recebido")
    private Double valor_recebido;

    @Column(name = "data_pagamento")
    private LocalDate data_pagamento;

    @Column(name = "percento_dentista")
    private Float percento_dentista;

    @Column(name = "tratamento_fechado")
    private boolean tratamento_fechado;

//    @Column(name = "valor_liquido")
//    private Double valor_liquido;

}
