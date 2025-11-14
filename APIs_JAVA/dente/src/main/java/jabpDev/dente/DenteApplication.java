package jabpDev.dente;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class DenteApplication {

	public static void main(String[] args) {
		SpringApplication.run(DenteApplication.class, args);
		System.out.println("========================================");
		System.out.println("|       Api rodando na porta 8080      |");
		System.out.println("========================================");
		System.out.println("\n");
	}

}
