package jabpDev.ServicosPro.api.Repositorys;

import jabpDev.ServicosPro.api.Dto.Response.ResponseMessageDto;
import jabpDev.ServicosPro.api.Entitys.Message;
import jabpDev.ServicosPro.api.Entitys.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface RepositoryMessage extends JpaRepository<Message,Long> {
    @Query(value = """
            select
            m.id as id,
            m.usuario_from as usuarioFrom,
            m.usuario_to as usuarioTo,
            m.message as message,
            m.data_time as dataTime,
            m.foto as foto 
            FROM Message m
            WHERE 
            (m.usuario_from = :usuarioFrom AND m.usuario_to =:usuarioTo)
            OR
            (m.usuario_to = :usuarioTo AND m.usuario_from = :usuarioFrom)
            ORDER BY m.data_time ASC  
            """,nativeQuery = true)
    List<ResponseMessageDto> findByUsuarioFromAndUsuarioToOrderByDataTime(Long usuarioFrom, Long usuarioTo);
}
