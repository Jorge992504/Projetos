package jabpDev.dente.api.entitys;

import jakarta.persistence.*;
import lombok.*;

import java.util.List;


@Entity
@Table
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Preco {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "preco")
    private Double preco;

    @Column(name = "plano")
    private String plano;

    @Column(name = "desconto")
    private Double desconto;

    @Column(name = "promocao")
    private Boolean promocao;

    @Column(name = "preco_promocao")
    private Double precoPromocao;

    @Column(name = "funcionalidades")
    @ElementCollection
    private List<String> funcionalidades;

}
