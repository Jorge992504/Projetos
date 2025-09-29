package jabp.chat.api.entitys;


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
    @JoinColumn(name = "sender_id")
    private Usuario sender;

    @ManyToOne
    @JoinColumn(name = "receiver_id")
    private Usuario receiver;

    @Column(nullable = false, columnDefinition = "TEXT")
    //conteudo da mensagem
    private String content;

    @Column(nullable = false)
    //data e hora que a mensagem foi enviada
    private LocalDateTime sentAt = LocalDateTime.now();

//    //data e hora que a mensagem foi entregue
//    private LocalDateTime deliveredAt;
//
//    //data e hora que a mensagem foi lida
//    private LocalDateTime readAt;
}


