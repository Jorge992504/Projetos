package jabp.chat.api.config;


import io.jsonwebtoken.Claims;
import jabp.chat.api.entitys.Usuario;
import jabp.chat.api.exceptions.AuthorizationException;
import jabp.chat.api.services.AuthorizationService;
import jabp.chat.api.services.LoginService;
import jabp.chat.api.services.UsuarioService;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.Collections;

@Component
@AllArgsConstructor
public class AuthorizationFilter extends OncePerRequestFilter {

    private final AuthorizationService authorization;
    private final UsuarioService usuarioService;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        String register = "/register";
        String login = "/login";
        String redefine = "/redefine";
        String publicResource = "/public";
        String path = request.getServletPath();
        if (path.equals(register) || path.equals(login) || path.equals(redefine) || path.equals(publicResource)){
            filterChain.doFilter(request,response);
        }else{
            writeErrorResponse(response,"Sem permissão");
        }
        boolean header = authorization.isTokenValid(request);
        if (!header){
            writeErrorResponse(response, "Token não informado ou Header mal formatado");
        }else{
            try {
                String token = request.getHeader("Authorization").substring(7);
                Claims claims = authorization.getClaimsForToken(token);
                String email = claims.get("email", String.class);
                //trocar depois de criar o user
                Usuario userDetails = usuarioService.buscaUsuario(email).orElseThrow(() -> new AuthorizationException("Usuário não encontrado"));
                UsernamePasswordAuthenticationToken authtoken = new UsernamePasswordAuthenticationToken(email, null, userDetails.getAuthorities());
                authtoken.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
                SecurityContextHolder.getContext().setAuthentication(authtoken);
                filterChain.doFilter(request,response);
            }catch (AuthorizationException authorizationException){
                writeErrorResponse(response, authorizationException.getMessage());
            }
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
