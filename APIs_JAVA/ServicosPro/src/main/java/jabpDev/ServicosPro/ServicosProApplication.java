package jabpDev.ServicosPro;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class ServicosProApplication {

	public static void main(String[] args) {
		SpringApplication.run(ServicosProApplication.class, args);
		System.out.println("*******---***---***---******");
		System.out.println("*                          *");
		System.out.println("* API RODANDO, PORTA: 8181 *");
		System.out.println("*                          *");
		System.out.println("*******---***---***---******");
	}

}
