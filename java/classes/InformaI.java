package classes;

import java.util.Scanner;

public class InformaI {

    public int getNome(){
        Scanner scanner = new Scanner(System.in);
        System.out.println("Informe o valor para iniciar 'I' ");
        int result = scanner.nextInt();
        return result;
    }
}
