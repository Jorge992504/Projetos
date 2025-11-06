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

//    @Column(name = "empresa_id")
//    private Long empresaId;
//
//    @Column(name = "paciente_id")
//    private Long pacienteId;
//
//    @Column(name = "dentista_id")
//    private Long dentistaId;
//
//    @Column(name = "servico_id")
//    private Long servicoId;

    @ManyToOne
    @JoinColumn(name = "paciente_id")
    private Paciente paciente;

    @ManyToOne
    @JoinColumn(name = "servico_id")
    private Servicos servico;

    @ManyToOne
    @JoinColumn(name = "empresa_id")
    private Empresa empresa;

    @ManyToOne
    @JoinColumn(name = "dentista_id")
    private Dentista dentista;

    @Column(name = "data_hora")
    private String dataHora;

    @Column(name = "observacoes")
    private String observacoes;

    @Column(name = "status")
    private String status;
}
