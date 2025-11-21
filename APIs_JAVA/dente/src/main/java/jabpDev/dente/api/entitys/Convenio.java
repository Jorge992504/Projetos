package jabpDev.dente.api.entitys;


import jakarta.persistence.*;
import lombok.*;

@Entity
@Table
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Convenio {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "empresa_id")
    private Empresa empresa;

    @Column(name = "parceiro")
    private String parceiro;

    @ManyToOne
    @JoinColumn(name = "servico_id")
    private Servicos servico;

    @Column(name = "valor_pago")
    private Double valor_pago;
}
