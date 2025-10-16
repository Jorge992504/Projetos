package jabpDev.dente.api.repositories;

import jabpDev.dente.api.dto.response.PacienteCPFDtoResponse;
import jabpDev.dente.api.entitys.Paciente;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PacienteRepository extends JpaRepository<Paciente, Long> {

    @Query(value = """
            select p.cpf as Paciente from Paciente p
            """)
    List<PacienteCPFDtoResponse> findByCpf();
}
