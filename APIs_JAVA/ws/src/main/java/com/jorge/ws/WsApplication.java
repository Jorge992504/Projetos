package com.jorge.ws;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class WsApplication {

	public static void main(String[] args) {
		SpringApplication.run(WsApplication.class, args);
		System.out.println("\n");
		System.out.println("|***************************************|");
		System.out.println("|****** API rodando na porta 9002 ******|");
		System.out.println("|***************************************|");
		System.out.println("\n");
	}

}
