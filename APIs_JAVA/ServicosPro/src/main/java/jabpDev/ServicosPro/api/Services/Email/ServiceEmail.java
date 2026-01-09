package jabpDev.ServicosPro.api.Services.Email;


import jabpDev.ServicosPro.api.Exceptions.CustomExeception.CustomException;
import lombok.AllArgsConstructor;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
@AllArgsConstructor
public class ServiceEmail {

    private final JavaMailSender javaMailSender;

    public void enviarEmailCadastro(String destinatario, String nome){
            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo(destinatario);
            String textoMessage = """
                    Seja muito bem-vindo(a)
                    Seu cadastro foi realizado com sucesso, e agora você já pode aproveitar todos os recursos 
                    de nossa plataforma.
                    """;
            message.setSubject("Olá, " + nome + "!");
            message.setText(textoMessage);
            javaMailSender.send(message);
    }

    public void enviarEmailRedefinirSenha(String destinatario, String nome, int codigo){
            StringBuilder texto = new StringBuilder();
            texto.append("Olá, ").append(nome).append("!\n\n")
                    .append("Recebemos uma solicitação para redefinir sua senha.\n\n")
                    .append("Para continuar com o processo, utilize o código abaixo:\n\n")
                    .append("🔑 Código de verificação: ").append(codigo).append("\n\n")
                    .append("Este código é válido por 10 minutos e deve ser inserido na tela de redefinição de senha do aplicativo.\n\n")
                    .append("Se você não solicitou esta redefinição, por favor ignore este e-mail — sua conta continuará segura.\n\n")
                    .append("Atenciosamente,\n")
                    .append("📧 suporte@servicesPro.com.br");
            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo(destinatario);
            message.setSubject("Redefinição de senha.");
            message.setText(texto.toString());
        javaMailSender.send(message);
    }
}
