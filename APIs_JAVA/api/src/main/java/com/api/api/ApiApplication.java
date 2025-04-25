package com.api.api;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.SpringBootConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.RequestMapping;

@SpringBootApplication
@RequestMapping("/api")
public class ApiApplication {

    public static void main(String[] args) {
        SpringApplication.run(ApiApplication.class, args);
        System.out.println("\n");
        System.out.println("|***************************************|");
        System.out.println("|****** API rodando na porta 9001 ******|");
        System.out.println("|***************************************|");
        System.out.println("\n");
    }

}