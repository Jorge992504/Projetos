package jabp.chat;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class ChatApplication {

	public static void main(String[] args) {
		SpringApplication.run(ChatApplication.class, args);
		System.out.println("=================================");
		System.out.println("|    API RODANDO, PORTA 8082    |");
		System.out.println("=================================");
	}

}
