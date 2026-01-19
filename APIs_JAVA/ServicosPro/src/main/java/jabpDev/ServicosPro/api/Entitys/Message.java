package jabpDev.ServicosPro.api.Entitys;


import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Entity
@Table
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Message {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "usuarioFrom")
    private Usuario usuarioFrom;

    @ManyToOne
    @JoinColumn(name = "usuarioTo")
    private Usuario usuarioTo;

    @Column(name = "message")
    private String message;

    @Column(name = "dataTime")
    private LocalDateTime dateTime;

    @Column(name = "foto")
    private String foto;

}
