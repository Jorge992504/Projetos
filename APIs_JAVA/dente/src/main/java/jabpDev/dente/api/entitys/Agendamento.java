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
public class Agendamento {


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "empresa_id")
    private Long empresaId;

    @Column(name = "paciente_id")
    private Long pacienteId;

    @Column(name = "dentista_id")
    private Long dentistaId;

    @Column(name = "servico_id")
    private Long servicoId;

    @Column(name = "data_hora")
    private String dataHora;

    @Column(name = "observacoes")
    private String observacoes;
}
