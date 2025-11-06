package jabpDev.dente;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class DenteApplication {

	public static void main(String[] args) {
		SpringApplication.run(DenteApplication.class, args);
		IO.println("========================================");
		IO.println("|       Api rodando na porta 5050      |");
		IO.println("========================================");
		IO.println("\n");
	}

}
