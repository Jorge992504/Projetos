package jabpDev.dente.api.services;

import jabpDev.dente.api.dto.request.RegistrarPrecosDtoRequest;
import jabpDev.dente.api.entitys.Preco;
import jabpDev.dente.api.exceptions.ErrorException;
import jabpDev.dente.api.repositories.PrecoRepository;
import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
public class PrecoService {
    private final PrecoRepository precoRepository;


    public List<RegistrarPrecosDtoRequest> buscarPrecos(){
        List<Preco> precos =  precoRepository.findAll();
        return precos.stream().map(
                p -> {
                    return new RegistrarPrecosDtoRequest(
                            p.getPreco(),
                            p.getPlano(),
                            p.getDesconto(),
                            p.getPromocao(),
                            p.getPrecoPromocao(),
                            p.getFuncionalidades()
                    );
                }).collect(Collectors.toList());
    }

    @Transactional
    public ResponseEntity<?> registrarPrecos(List<RegistrarPrecosDtoRequest> body) {

        List<Preco> salvar = new ArrayList<>();

        for (RegistrarPrecosDtoRequest dto : body) {
            Preco preco = new Preco();
            preco.setPlano(dto.plano());
            preco.setPreco(dto.preco());
            preco.setDesconto(dto.desconto());
            preco.setPromocao(dto.promocao());
            preco.setPrecoPromocao(dto.precoPromocao());
            preco.setFuncionalidades(dto.funcionalidades());

            salvar.add(preco);
        }

        precoRepository.saveAll(salvar);

        return ResponseEntity.ok("Planos cadastrados com sucesso!");
    }
}
