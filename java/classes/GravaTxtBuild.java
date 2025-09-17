package classes;

import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Scanner;

public class GravaTxtBuild {

    public void gravaTxtBuild(String path){
        Scanner scanner = new Scanner(System.in);

        System.out.println("Informe file");
        String fileT = scanner.nextLine();

        System.out.println("Informe o jar");
        String jarT = scanner.nextLine();

        System.out.println("Informe o main");
        String mainTxt = scanner.nextLine();

        System.out.println("Informe o build");
        String buildT = scanner.nextLine();

        System.out.println("Informe codigo cmd");
        String cmdT = scanner.nextLine();

        LocalDateTime agora = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd/HH-mm-ss");
        String timestamp = agora.format(formatter);

        StringBuilder conteudo = new StringBuilder();
        conteudo.append("==================== DADOS PARA BUILD JAR ==========");
        conteudo.append(String.format(timestamp));
        conteudo.append("==========\n");
        conteudo.append(String.format(fileT));
        conteudo.append(String.format( jarT));
        conteudo.append(String.format( mainTxt));
        conteudo.append(String.format( buildT));
        conteudo.append(String.format( cmdT));
        conteudo.append("============================================================");



        String caminho = Paths.get(path, "build-" + timestamp +".txt").toString();
        try (FileWriter writer = new FileWriter(caminho)){
            writer.write(conteudo.toString());
            System.out.println("Arquivo gravado em: "+ path);
        }catch (IOException e){
            System.out.println("Arquivo não gravado em: "+ path+ e.getMessage());
        }
    }
}
