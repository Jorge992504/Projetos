import classes.GravaTxtBuild;
import classes.InformaI;
import classes.ListInt;
import classes.SaveTxt;

import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class Main {


    public static void main(String[] args){
//        ListInt listInt = new ListInt();
//        var newList = new ArrayList<>();
//        var lista =  listInt.addInt();
////        for (var n : lista){
//            System.out.println(lista);
////        }
//          for (int i = 0; i < lista.size(); i++){
//
//              if (lista.get(i)/2 != 0){
//                  newList.add(lista.get(i));
//              }else{
//                  lista.remove(lista.get(i));
//              }
//          }
//          System.out.println(newList);
//
//        System.out.println("\n");
//        System.out.println("------------------------------------------");
//        System.out.println("\n");
//
//
//        InformaI informaI = new InformaI();
//        var result = informaI.getNome();
//        newList.clear();
//        for (int i = result; i <= result+5; i++){
//            newList.add(i);
//        }
//        System.out.println("Segunda lista "+ newList);
//
//
//        System.out.println("\n");
//        System.out.println("------------------------------------------");
//        System.out.println("\n");
//
        SaveTxt txt = new SaveTxt();
        Scanner scanner = new Scanner(System.in);
        System.out.println("Informa o caminho para gravar os dados: ");
        String path = scanner.nextLine();
        if (path.isEmpty()){
            System.out.println("Erro ao copiar caminho");
        }else{
            txt.saveTxt(path);
        }
//        if (path.isEmpty()){
//            System.out.println("Erro ao copiar caminho");
//        }else{
//            GravaTxtBuild gravaTxtBuild = new GravaTxtBuild();
//            gravaTxtBuild.gravaTxtBuild(path);
//        }

        scanner.close();

    }
}
