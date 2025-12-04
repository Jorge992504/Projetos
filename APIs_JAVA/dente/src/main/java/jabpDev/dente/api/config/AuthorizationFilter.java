package jabpDev.dente.api.config;


import io.jsonwebtoken.Claims;
import jabpDev.dente.api.exceptions.ErrorException;
import jabpDev.dente.api.repositories.EmpresaRepository;
import jabpDev.dente.api.services.ServicesGerais;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

@Component
@AllArgsConstructor
public class AuthorizationFilter extends OncePerRequestFilter {
    private final Filter filter;
    private final ServicesGerais servicesGerais;
    private final EmpresaRepository empresaRepository;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)throws ServletException, IOException {

        String path = request.getServletPath();
        String header = request.getHeader("Authorization");
        

        if (path.equals(filter.getLogin()) ||
                path.equals(filter.getRegister()) ||
                path.startsWith(filter.getRedefine()) || path.startsWith("/public/") ||
                path.equals(filter.getCard()) || path.equals(filter.getCardStatus()) ||
                path.equals(filter.getPix())  || path.equals(filter.getPixStatus())  ||
                path.equals(filter.getCardPublicKey()) || path.equals(filter.getPrecoFind())
        ){
            filterChain.doFilter(request,response);
            return;
        }

        if (header == null || !header.startsWith("Bearer ")){
            writeErrorResponse(response, "Token não informado");
            return;
        }
        try {
            String token = header.substring(7);
            Claims claims = servicesGerais.validarToken(token, response);
            if (claims.isEmpty()){
                writeErrorResponse(response, "Token invalido, realizar login");
                return;
            }
            String email = claims.get("email", String.class);
            var userDetail = empresaRepository.findByEmailClinica(email).orElseThrow(() -> new ErrorException("Empresa não encontrada"));

            UsernamePasswordAuthenticationToken auth = new UsernamePasswordAuthenticationToken(userDetail, null, userDetail.getAuthorities());

            auth.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
            SecurityContextHolder.getContext().setAuthentication(auth);

            filterChain.doFilter(request,response);
        } catch (IOException e){
            writeErrorResponse(response, e.getMessage());
        }


    }

    private void writeErrorResponse(HttpServletResponse response, String message) throws IOException {
        response.setStatus(HttpStatus.UNAUTHORIZED.value());
        response.setContentType("application/json");
        response.getWriter().write(
                String.format("{\"message\": \"%s\"}", message)
        );
    }
}
