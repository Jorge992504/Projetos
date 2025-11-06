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
public class Historico {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;


    @ManyToOne
    @JoinColumn(name = "paciente_id")
    private Paciente paciente;


    @ManyToOne
    @JoinColumn(name = "empresa_id")
    private Empresa empresa;

    @ManyToOne
    @JoinColumn(name = "atendimento_id")
    private Atendimento atendimento;


    @Column(name = "arquivo")
    private String arquivo;

    @Column(name = "data", nullable = false)
    private String data;


}
