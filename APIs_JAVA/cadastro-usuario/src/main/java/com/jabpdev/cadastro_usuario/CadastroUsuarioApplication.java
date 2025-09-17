package com.jabpdev.cadastro_usuario;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class CadastroUsuarioApplication {

	public static void main(String[] args) {
		SpringApplication.run(CadastroUsuarioApplication.class, args);
		System.out.println("\n");
		System.out.println("|***************************************|");
		System.out.println("|****** API rodando na porta 9090 ******|");
		System.out.println("|***************************************|");
		System.out.println("\n");
	}

}
