package com.compras.api;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class ApiApplication {

	public static void main(String[] args){
		SpringApplication.run(ApiApplication.class, args);
		System.out.println("\n");
		System.out.println("|***************************************|");
		System.out.println("|****** API rodando na porta 8081 ******|");
		System.out.println("|***************************************|");
		System.out.println("\n");
	}

}
