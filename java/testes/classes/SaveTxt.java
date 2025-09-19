package classes;

import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Scanner;

public class SaveTxt {
    public void saveTxt(String path){
        Scanner scanner = new Scanner(System.in);

        System.out.println("Informe seu nome");
        String name = scanner.nextLine();

        System.out.println("Informe sua idade");
        int age = scanner.nextInt();
        scanner.nextLine();

        System.out.println("Informe a cidade onde mora");
        String city = scanner.nextLine();

        System.out.println("Informe seu bairro");
        String bairro = scanner.nextLine();

        System.out.println("Informe seu telefone");
        String fone = scanner.nextLine();

        LocalDateTime data = LocalDateTime.now();
        LocalDateTime agora = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd_HH-mm-ss");
        String timestamp = agora.format(formatter);

        StringBuilder conteudo = new StringBuilder();
        conteudo.append("==================== DADOS DO USUÁRIO ==========");
        conteudo.append(String.format(data.toString()));
        conteudo.append("==========\n");
        conteudo.append(String.format("| %-15s : %-30s |\n", "Nome", name));
        conteudo.append(String.format("| %-15s : %-30s |\n", "Idade", age));
        conteudo.append(String.format("| %-15s : %-30s |\n", "Cidade", city));
        conteudo.append(String.format("| %-15s : %-30s |\n", "Bairro", bairro));
        conteudo.append(String.format("| %-15s : %-30s |\n", "Telefone", fone));
        conteudo.append("============================================================");



        String caminho = Paths.get(path, "dados-" + timestamp +".txt").toString();
        try (FileWriter writer = new FileWriter(caminho)){
            writer.write(conteudo.toString());
            System.out.println("Arquivo gravado em: "+ path);
        }catch (IOException e){
            System.out.println("Arquivo não gravado em: "+ path+ e.getMessage());
        }
    }
}
