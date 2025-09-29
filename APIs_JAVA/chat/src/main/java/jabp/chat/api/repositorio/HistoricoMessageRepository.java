package jabp.chat.api.repositorio;

import jabp.chat.api.dto.response.HistoricoMessagesDtoResponse;
import jabp.chat.api.entitys.Message;
import jabp.chat.api.entitys.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface HistoricoMessageRepository extends JpaRepository<Message, Long> {


    // Buscar todas as mensagens entre dois usuários
    List<Message> findBySenderIdAndReceiverIdOrSenderIdAndReceiverIdOrderBySentAtAsc(
            Long senderId, Long receiverId, Long receiverId2, Long senderId2
    );


    List<Message> findAllBySenderIdOrderBySentAtDesc(Long senderId);


}
