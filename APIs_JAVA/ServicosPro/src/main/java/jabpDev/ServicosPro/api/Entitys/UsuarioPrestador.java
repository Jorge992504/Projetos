package jabpDev.ServicosPro.api.Entitys;


import jakarta.persistence.*;
import lombok.*;

@Entity
@Table
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UsuarioPrestador {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "categoria")
    private Categorias categoria;

    @ManyToOne
    @JoinColumn(name = "usuario")
    private Usuario usuario;

    @Column(name = "avaliacao")
    private Double avaliacao;

    @Column(name = "qtdeServicos")
    private Integer qtdeServicos;
}
