package classes;

import java.util.Scanner;

public class PintaCarrinho {

    public void pintaCarrinho(){
        Scanner scanner = new Scanner(System.in);

        String reset = "\u001B[0m";
        String vermelho = "\u001B[31m";
        String verde = "\u001B[32m";
        String amarelo = "\u001B[33m";
        String azul = "\u001B[34m";
        String magenta = "\u001B[35m";
        String ciano = "\u001B[36m";



        System.out.println("Escolha a cor da carroceria (vermelho, verde, amarelo, azul, magenta, ciano): ");
        String corCarroceriaEscolhida = scanner.nextLine().toLowerCase();

        System.out.println("Escolha a cor das rodas (vermelho, verde, amarelo, azul, magenta, ciano): ");
        String corRodasEscolhida = scanner.nextLine().toLowerCase();

        // Método auxiliar para mapear texto -> cor ANSI
        String corCarroceria = escolherCor(corCarroceriaEscolhida, reset, vermelho, verde, amarelo, azul, magenta, ciano);
        String corRodas = escolherCor(corRodasEscolhida, reset, vermelho, verde, amarelo, azul, magenta, ciano);

        System.out.println(corCarroceria + "      ______");
        System.out.println("  ___/      \\___");
        System.out.println(" |              |");
        System.out.println(" '-(" + corRodas + "o" + corCarroceria + ")------(" + corRodas + "o" + corCarroceria + ")-'" + reset);

        scanner.close();


    }


    private static String escolherCor(String cor, String reset, String vermelho, String verde, String amarelo,
                                      String azul, String magenta, String ciano) {
        switch (cor) {
            case "vermelho": return vermelho;
            case "verde": return verde;
            case "amarelo": return amarelo;
            case "azul": return azul;
            case "magenta": return magenta;
            case "ciano": return ciano;
            default:
                System.out.println("Cor não reconhecida: " + cor + ", usando padrão.");
                return reset;
        }
    }

}
