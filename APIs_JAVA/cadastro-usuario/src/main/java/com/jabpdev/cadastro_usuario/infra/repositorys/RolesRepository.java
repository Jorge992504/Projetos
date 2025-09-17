package com.jabpdev.cadastro_usuario.infra.repositorys;

import com.jabpdev.cadastro_usuario.infra.entitys.Roles;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface RolesRepository extends JpaRepository<Roles, Long> {
}
