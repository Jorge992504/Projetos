package jabpdev.nahora.api.repositorios;

import jabpdev.nahora.api.dto.response.PromocoesDtoResponse;
import jabpdev.nahora.api.entity.Promocoes;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface PromocoesRepository extends JpaRepository<Promocoes, Long> {
    @Query(value = """
        select 
            p.id, 
            p.image, 
            p.nome, 
            a.nome,
            p.quantidade, 
            p.descricao,
            a.descricao_qtde,
            a.quantidade,
            p.descricao_qtde as Produtos,
            pr.id, 
            pr.produto_adicional_id,
            pr.preco as Promocoes, 
            v.preco as Variacoes
        from Promocoes pr join Produtos p on pr.produto_id = p.id join 
        produtos a on pr.produto_adicional_id = a.id join 
        variacoes v on v.produto_id = p.id 
        where pr.ativo = true
    """, nativeQuery = true)
    List<PromocoesDtoResponse> findByAtivo();
}