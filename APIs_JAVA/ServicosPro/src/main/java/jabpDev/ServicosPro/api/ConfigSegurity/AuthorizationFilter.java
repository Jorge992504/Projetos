package jabpDev.ServicosPro.api.ConfigSegurity;

import io.jsonwebtoken.Claims;
import jabpDev.ServicosPro.api.Entitys.Usuario;
import jabpDev.ServicosPro.api.Exceptions.CustomExeception.ExceptionToken;
import jabpDev.ServicosPro.api.Repositorys.RepositoryUsuario;
import jabpDev.ServicosPro.api.Services.Geral.ServicosGeral;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.AllArgsConstructor;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

@Component
@AllArgsConstructor
public class AuthorizationFilter extends OncePerRequestFilter {

    private final FiltrosLiberados filtrosLiberados;
    private final ServicosGeral servicosGerais;
    private final RepositoryUsuario repositoryUsuario;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)throws ServletException, IOException {
        String path = request.getServletPath();
        String header = request.getHeader("Authorization");

        if (path.equals(filtrosLiberados.getLogin()) ||
                path.equals(filtrosLiberados.getRegistrar()) ||
                path.equals(filtrosLiberados.getRedefinirSenha()) ||
                path.equals(filtrosLiberados.getReceberEmail()) ||
                path.equals(filtrosLiberados.getValidarCodigo()) ||
                path.equals(filtrosLiberados.getValidarConexao())
        ){
            filterChain.doFilter(request,response);
            return;
        }

        if(header == null || !header.startsWith("Bearer ")){
            ExceptionToken.escreverErro(response,"Token não informado");
            return;
        }
        try {
            String token = header.substring(7);
            Claims claims = servicosGerais.validarTokenRequesicao(token,response);
            if (claims.isEmpty()){
                ExceptionToken.escreverErro(response,"Token invalido");
                return;
            }
            String email = claims.get("email", String.class);


            UsernamePasswordAuthenticationToken auth = new UsernamePasswordAuthenticationToken(email, null, List.of());

            auth.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
            SecurityContextHolder.getContext().setAuthentication(auth);

            filterChain.doFilter(request,response);
        } catch (Exception e) {
            System.out.println("Exception: "+ e.getMessage());
            ExceptionToken.escreverErro(response,"Token invalido, realizar login novamente");
        }
    }
}
