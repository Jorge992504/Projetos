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
public class Premium {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "empresa_id")
    private Empresa empresa;

    @Column(name = "premium")
    private Boolean premium;

    @Column(name = "periodo_teste")
    private Boolean periodoTeste;

    @Column(name = "data_teste")
    private LocalDate dataTeste;

    @Column(name = "data_premium")
    private LocalDate dataPremium;
}
