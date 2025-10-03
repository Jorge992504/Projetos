package jabpdev.nahora.api.repositorios;

import jabpdev.nahora.api.dto.response.ProdutoEspecificoDtoResponse;
import jabpdev.nahora.api.dto.response.PromocoesDtoResponse;
import jabpdev.nahora.api.entity.Produtos;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
public interface ProdutoRepository extends JpaRepository<Produtos, Long> {

    @Query(value = """
        select 
            p.id, 
            p.image, 
            p.nome, 
            p.quantidade, 
            p.descricao,
            p.descricao_qtde as Produtos, 
            v.preco as Variacoes
        from Produtos p join variacoes v on p.id = v.produto_id
        where p.categoria_id = ?1
    """, nativeQuery = true)
    List<ProdutoEspecificoDtoResponse> findByCategoriaId(Integer menu);


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
        where pr.ativo = true and p.categoria_id = ?1
    """, nativeQuery = true)
    List<PromocoesDtoResponse> findByAtivoAndCategoriaId(Integer menu);
}