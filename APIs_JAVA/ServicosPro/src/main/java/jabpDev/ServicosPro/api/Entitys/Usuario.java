package jabpDev.ServicosPro.api.Entitys;


import jakarta.persistence.*;
import lombok.*;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.time.LocalDate;
import java.util.Collection;
import java.util.Date;
import java.util.List;

@Entity
@Table
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Usuario implements UserDetails {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "nome")
    private String nome;

    @Column(name = "email",unique = true,nullable = false)
    private String email;

    @Column(name = "senha",nullable = false)
    private String senha;

    @Column(name = "foto")
    private String foto;

    @Column(name = "tipoUsuario")
    private String tipoUsuario;

    @Column(name = "tipoPessoa")
    private String tipoPessoa;

    @Column(name = "cpf_cnpj")
    private String cpf_cnpj;

    @Column(name = "dataNascimento")
    private LocalDate dataNascimento;

    @Column(name = "telefone")
    private String telefone;

    @Column(name = "endereco")
    private String endereco;

    @OneToOne
    @JoinColumn(name = "categoriaPrestador")
    private Categorias categoriaPrestador;

    @Column(name = "termosPolitica",nullable = false)
    private Boolean termosPolitica;

    @Column(name = "dataRegistro")
    private LocalDate dataRegistro;

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return List.of();
    }

    @Override
    public String getUsername() {
        return email;
    }

    @Override
    public String getPassword(){
        return senha;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return false;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }

}
