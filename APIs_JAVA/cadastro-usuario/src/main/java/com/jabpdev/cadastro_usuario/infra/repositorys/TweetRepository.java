package com.jabpdev.cadastro_usuario.infra.repositorys;

import com.jabpdev.cadastro_usuario.infra.entitys.Tweet;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


@Repository
public interface TweetRepository extends JpaRepository<Tweet,Long> {
}
