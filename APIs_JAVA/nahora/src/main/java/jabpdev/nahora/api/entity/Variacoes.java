package jabpdev.nahora.api.entity;


import jakarta.persistence.*;
import lombok.*;

@Entity
@Table
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Variacoes {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "produto_id", nullable = false)
    private Produtos produto;

    @Column(name = "preco", nullable = false)
    private Double preco;

    @Column(name = "quantidade")
    private Float quantidade;

    @Column(name = "descricaoQtde")
    private String descricaoQtde;
}
