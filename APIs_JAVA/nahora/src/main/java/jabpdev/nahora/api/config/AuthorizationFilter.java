package jabpdev.nahora.api.config;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;


@Component
@AllArgsConstructor
public class AuthorizationFilter extends OncePerRequestFilter {

    private final Filter filter;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)throws ServletException, IOException {
        String path = request.getServletPath();
        IO.println("Path que entra no filter: "+ path);
        if (path.equals(filter.getPromocoes()) ||
                path.startsWith(filter.getMenu()) ||
                path.equals(filter.getLogin()) ||
                path.equals(filter.getRegister()) ||
                path.equals(filter.getRedefine()) ||
                path.startsWith(filter.getPublicResource())){
            filterChain.doFilter(request,response);

        }
    }

}
