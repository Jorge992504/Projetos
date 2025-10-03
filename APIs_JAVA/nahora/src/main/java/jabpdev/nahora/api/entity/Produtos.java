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
public class Produtos {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "nome", nullable = false)
    private String nome;

    @Column(name = "descricao")
    private String descricao;

    @Column(name = "image")
    private String image;

    @OneToOne
    @JoinColumn(name = "categoria_id", referencedColumnName = "id")
    private Categorias categoria;

    @Column(name = "disponivel")
    private Boolean disponivel;

    @Column(name = "quantidade")
    private Float quantidade;

    @Column(name = "descricaoQtde")
    private String descricaoQtde;

}
