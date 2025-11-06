package jabpDev.dente.api.repositories;

import jabpDev.dente.api.dto.response.PacienteDtoResponse;
import jabpDev.dente.api.entitys.Paciente;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface PacienteRepository extends JpaRepository<Paciente, Long> {

    List<PacienteDtoResponse> findByEmpresaId(Long empresaId);

//    @Query("SELECT p FROM Paciente p WHERE p.cpf = :cpf AND p.empresa_id = :empresaId")
    Optional<Paciente> findByCpfAndEmpresaId(String cpf, Long empresaId);

    Optional<Paciente> findByIdAndEmpresaId(Long id, Long empresaId);
}
