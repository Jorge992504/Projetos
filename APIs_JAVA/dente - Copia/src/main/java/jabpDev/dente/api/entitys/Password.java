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
public class Password {


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;


    @Column(name = "empresa_id")
    private Long empresaId;


    @Column(name = "codigo")
    private int codigo;


}
