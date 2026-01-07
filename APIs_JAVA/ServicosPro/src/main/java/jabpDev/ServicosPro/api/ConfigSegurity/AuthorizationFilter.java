package jabpDev.ServicosPro.api.ConfigSegurity;

import io.jsonwebtoken.Claims;
import jabpDev.ServicosPro.api.Exceptions.CustomExeception.ExceptionToken;
import jabpDev.ServicosPro.api.Services.Geral.ServicosGeral;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

@Component
@AllArgsConstructor
public class AuthorizationFilter extends OncePerRequestFilter {

    private final FiltrosLiberados filtrosLiberados;
    private final ServicosGeral servicosGerais;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)throws ServletException, IOException {
        try {
            String path = request.getServletPath();
            String header = request.getHeader("Authorization");

            if (path.equals(filtrosLiberados.getLogin()) || path.equals(filtrosLiberados.getRegistrar()) || path.equals(filtrosLiberados.getRedefinirSenha())){
                filterChain.doFilter(request,response);
                return;
            }

            if(header == null || !header.startsWith("Bearer ")){
               ExceptionToken.escreverErro(response,"Token não informado");
               return;
            }

            String token = header.substring(7);
            Claims claims = servicosGerais.validarTokenRequesicao(token,response);
            if (claims.isEmpty()){
                ExceptionToken.escreverErro(response,"Token invalido");
                return;
            }
            String usuario = claims.get("email", String.class);
            if (usuario.isEmpty()){
                ExceptionToken.escreverErro(response,"Usuário sem permissão");
                return;
            }

            filterChain.doFilter(request,response);
        } catch (Exception e) {
            ExceptionToken.escreverErro(response,"Token invalido, realizar login novamente");
        }
    }
}
