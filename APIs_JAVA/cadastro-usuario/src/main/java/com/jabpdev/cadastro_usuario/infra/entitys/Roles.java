package com.jabpdev.cadastro_usuario.infra.entitys;


import jakarta.persistence.*;
import lombok.*;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Table(name = "roles")
@Entity
public class Roles {


    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "role_id")
    private Long id;

    private String name;


    public enum Values{
        ADMIN(1L),
        BASIC(2L);

        Long valueId;

        Values(Long id){
             this.valueId = id;
        }

        public Long getValueId(){
            return valueId;
        }
    }
}
