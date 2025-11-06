package jabpDev.dente.api.dto.request;

import jakarta.persistence.Column;

public record RegistrarDentistaDtoRequest(

         String nome,
         String email,
         String telefone,
         String cro
) {
}
