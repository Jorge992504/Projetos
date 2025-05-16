package com.api.aumigo.ApiAumigo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
public class ApiAumigoApplication {

	public static void main(String[] args) {
		SpringApplication.run(ApiAumigoApplication.class, args);
		System.out.println("\n");
		System.out.println("|***************************************|");
		System.out.println("|****** API rodando na porta 9004 ******|");
		System.out.println("|***************************************|");
		System.out.println("\n");
	}

}
