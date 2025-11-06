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
public class Dentista {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "nome")
    private String nome;

    @Column(name = "email", nullable = false)
    private String email;

    @Column(name = "telefone")
    private String telefone;

    @Column(name = "cro", nullable = false)
    private String cro;

    @Column(name = "empresa_id")
    private Long empresaId;

    @Column(name = "ativo")
    private boolean ativo;
}
