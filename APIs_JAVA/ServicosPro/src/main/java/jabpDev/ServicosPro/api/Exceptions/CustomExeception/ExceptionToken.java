package jabpDev.ServicosPro.api.Exceptions.CustomExeception;

import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class ExceptionToken {
    private ExceptionToken(){}

    public static void escreverErro(HttpServletResponse response, String message)throws IOException {
        response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        response.getWriter().write("""
            { "message": "%s" }
        """.formatted(message));
    }

}
