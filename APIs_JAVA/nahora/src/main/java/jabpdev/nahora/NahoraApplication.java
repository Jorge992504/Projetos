package jabpdev.nahora;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import static java.lang.IO.println;

@SpringBootApplication
public class NahoraApplication {

	public static void main(String[] args) {
		SpringApplication.run(NahoraApplication.class, args
		);
		println("=======================================");
		println("| ---> API RODANDO NA PORTA 6060 <--- |");
		println("=======================================");
	}

}
