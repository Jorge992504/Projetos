package com.jabpdev.cadastro_usuario.infra.entitys;


import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;

import java.time.Instant;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Table(name = "tweet")
@Entity
public class Tweet {


    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    @Column(name = "tweet_id")
    Long id;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private Usuario usuario; //

    @Column(name = "content")
    private String content;

    @Column(name = "data")
    @CreationTimestamp
    private Instant creationTimestamp;


}
