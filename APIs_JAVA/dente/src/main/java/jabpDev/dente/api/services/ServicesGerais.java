package jabpDev.dente.api.services;


import io.jsonwebtoken.*;
import io.jsonwebtoken.security.Keys;
import jabpDev.dente.api.entitys.Agendamento;
import jabpDev.dente.api.entitys.Dentista;
import jabpDev.dente.api.entitys.Paciente;
import jabpDev.dente.api.exceptions.ErrorException;
import lombok.Getter;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Service
public class ServicesGerais {

    @Value("${jwt.secret}")
    private String secretKey;
    @Value("${jwt.expiration}")
    private Long expirationTokenTime;
    @Getter
    @Value("${app.base-url}")
    public String baseUrl;

    private final JavaMailSender javaMailSender;

    public ServicesGerais(JavaMailSender javaMailSender){
        this.javaMailSender = javaMailSender;
    }


    public String geraToken(String email){
        Map<String, Object> claims = new HashMap<>();
        claims.put("email",email);
        return Jwts.builder().setClaims(claims)
                .setIssuedAt(new Date(System.currentTimeMillis()))
                .setExpiration(Date.from(LocalDateTime.now().plusDays(expirationTokenTime).atZone(ZoneId.systemDefault()).toInstant()))
                .signWith(Keys.hmacShaKeyFor(secretKey.getBytes()), SignatureAlgorithm.HS256)
                .compact();
    }


    public Claims validarToken(String token) {
        try {
            return Jwts.parserBuilder()
                    .setSigningKey(Keys.hmacShaKeyFor(secretKey.getBytes()))
                    .build()
                    .parseClaimsJws(token)
                    .getBody();
        } catch (ExpiredJwtException e) {
            throw new ErrorException("Token expirado");
        } catch (JwtException e) {
            throw new ErrorException("Token inválido");
        }
    }

    public void enviarEmailRedefinirSenha(String destinatario, int codigo, String nome) {
        StringBuilder texto = new StringBuilder();

        texto.append("Olá, ").append(nome).append("!\n\n")
                .append("Recebemos uma solicitação para redefinir sua senha na plataforma Dente.\n\n")
                .append("Para continuar com o processo, utilize o código abaixo:\n\n")
                .append("🔑 Código de verificação: ").append(codigo).append("\n\n")
                .append("Este código é válido por 10 minutos e deve ser inserido na tela de redefinição de senha do aplicativo ou sistema.\n\n")
                .append("Se você não solicitou esta redefinição, por favor ignore este e-mail — sua conta continuará segura.\n\n")
                .append("Atenciosamente,\n")
                .append("Equipe Dente 🦷\n\n")
                .append("📧 suporte@dente.com.br");

        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(destinatario);
        message.setSubject("Redefinição de senha - Dente");
        message.setText(texto.toString());

        javaMailSender.send(message);
    }

    public void enviarEmailCadastro(String destinatario, String nome) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(destinatario);
        String text = """
                Seja muito bem-vindo(a) à Dente 🦷✨
                Seu cadastro foi concluído com sucesso, e agora você já pode aproveitar todos os recursos da nossa\nplataforma para facilitar o gerenciamento da sua clínica.
                Aqui estão algumas coisas que você pode fazer a partir de agora:
                - Acessar o painel da sua empresa,
                - Cadastrar pacientes e agendamentos,
                - Gerenciar sua equipe e seus serviços.
                Caso tenha alguma dúvida ou precise de ajuda, nossa equipe de suporte está sempre pronta para atender você!
                \uD83D\uDCE9 E-mail de suporte: suporte@dente.com.br
                """;
        message.setSubject("Olá, "+ nome +"!");
        message.setText(text);
        javaMailSender.send(message);
    }

    public void enviaEmailCadastroPaciente(String destinatario, String nome, String emailClinica) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(destinatario);
        message.setFrom(emailClinica);
        String text = """
                Seja muito bem-vindo(a) à Clínica Dente! 😁
                Seu cadastro foi realizado com sucesso e agora você \njá faz parte da nossa família de sorrisos saudáveis.
                Nosso compromisso é cuidar do seu sorriso com atenção, carinho e profissionalismo 💙
                Em caso de dúvidas ou para agendar sua primeira consulta, entre em contato com a nossa equipe — estamos sempre à disposição!
                """;
        message.setSubject("Olá, "+ nome +"! 🦷✨");
        message.setText(text);
        javaMailSender.send(message);
    }

    public void enviaEmailCadastroDentista(String destinatario, String nome, String emailClinica) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(destinatario);
        message.setFrom(emailClinica);
        message.setSubject("Olá, "+ nome +"! 🦷✨ Bem-vindo(a) à equipe!");
        String text = """
                Parabéns, Dr(a).
                Agora você faz parte da nossa família de profissionais\ndedicados a transformar sorrisos e promover saúde com excelência. 😁✨
                Estamos felizes em ter você conosco e esperamos que esta\njornada seja repleta de conquistas, aprendizados e muitos sorrisos felizes.
                Seja bem-vindo(a) à nossa equipe! 🦷💙
                """;
        message.setText(text);
        javaMailSender.send(message);
    }

    public void enviarEmailConfirmacaoAgendamento(Paciente paciente, Dentista dentista, Agendamento agendamento, String emailClinica) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(paciente.getEmail());
        message.setFrom(emailClinica);
        message.setSubject("Confirmação de Agendamento - 🦷 Dente Saúde");

        String textoPaciente = String.format("""
        Olá %s! 😁
        
        Seu agendamento foi confirmado com sucesso.
        
        📅 Data: %s
        ⏰ Hora: %s
        🦷 Dentista: Dr(a). %s
        
        Estamos ansiosos para recebê-lo(a) e cuidar do seu sorriso com toda atenção e carinho.
        
        Atenciosamente,
        Equipe Dente Saúde 💙
        """,
        paciente.getNome(),
        new SimpleDateFormat("dd/MM/yyyy").format(agendamento.getDataHora()),
        new SimpleDateFormat("HH:mm").format(agendamento.getDataHora())
        );
        message.setText(textoPaciente);
        javaMailSender.send(message);


        message.setTo(dentista.getEmail());
        message.setFrom(emailClinica);
        message.setSubject("Novo Agendamento Confirmado - 🦷 Dente Saúde");

        String textoDentista = String.format("""
        Olá Dr(a). %s! 🦷
        
        Um novo agendamento foi realizado:
        
        📅 Data: %s
        ⏰ Hora: %s
        👤 Paciente: %s
        
        Prepare-se para atender e proporcionar a melhor experiência ao paciente.
        
        Atenciosamente,
        Equipe Dente Saúde 💙
        """,
        new SimpleDateFormat("dd/MM/yyyy").format(agendamento.getDataHora()),
        new SimpleDateFormat("HH:mm").format(agendamento.getDataHora())
        );

        message.setText(textoDentista);
        javaMailSender.send(message);
    }



    public  boolean isValid(String cnpj) {
        if (cnpj == null) return false;

        // Remove tudo que não é dígito
        cnpj = cnpj.replaceAll("\\D", "");

        // Deve ter 14 dígitos
        if (cnpj.length() != 14) return false;

        // Checa sequências repetidas
        if (cnpj.matches("(\\d)\\1{13}")) return false;

        int[] peso1 = {5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2};
        int[] peso2 = {6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2};

        try {
            int dig1 = calcularDigito(cnpj.substring(0, 12), peso1);
            int dig2 = calcularDigito(cnpj.substring(0, 12) + dig1, peso2);

            return cnpj.equals(cnpj.substring(0, 12) + dig1 + dig2);
        } catch (NumberFormatException e) {
            return false;
        }
    }

    private static int calcularDigito(String str, int[] peso) {
        int soma = 0;
        for (int i = 0; i < peso.length; i++) {
            soma += Character.getNumericValue(str.charAt(i)) * peso[i];
        }
        int resto = soma % 11;
        return (resto < 2) ? 0 : 11 - resto;
    }


    public boolean isValidCPF(String cpf) {
        if (cpf == null) return false;

        // Remove tudo que não é número
        cpf = cpf.replaceAll("\\D", "");

        // O CPF deve ter 11 dígitos
        if (cpf.length() != 11) return false;

        // Rejeita CPFs com todos os dígitos iguais (ex: 111.111.111-11)
        if (cpf.matches("(\\d)\\1{10}")) return false;

        try {
            int dig1 = calcularDigitoCPF(cpf.substring(0, 9), 10);
            int dig2 = calcularDigitoCPF(cpf.substring(0, 9) + dig1, 11);

            return cpf.equals(cpf.substring(0, 9) + dig1 + dig2);
        } catch (NumberFormatException e) {
            return false;
        }
    }

    private static int calcularDigitoCPF(String str, int pesoInicial) {
        int soma = 0;
        int peso = pesoInicial;

        for (int i = 0; i < str.length(); i++) {
            soma += Character.getNumericValue(str.charAt(i)) * peso--;
        }

        int resto = soma % 11;
        return (resto < 2) ? 0 : 11 - resto;
    }

}
