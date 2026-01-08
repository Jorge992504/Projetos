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
public class Categorias {

    @Id
    @Column(name = "id")
    private Long id;

    @Column(name = "nome")
    private String nome;
}
