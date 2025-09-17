package com.jabpdev.cadastro_usuario.infra.repositorys;

import com.jabpdev.cadastro_usuario.infra.entitys.Usuario;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;


@Repository
public interface UsuarioRepository extends JpaRepository<Usuario, Long> {

    Optional<Usuario> findByEmail(String email);

    @Transactional
    void deleteByEmail(String email);

}
