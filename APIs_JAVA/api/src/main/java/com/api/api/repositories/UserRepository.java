package com.api.api.repositories;

import com.api.api.models.Users;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<Users, Long> {

    Optional<Users> findByEmail(String email);
    List<Users> findByVerificado(boolean verificado);
    //Optional<Users> findByEmailAndVerificado(String email, boolean verificado);
}