package com.api.aumigo.ApiAumigo.service;


import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailService {

    private final JavaMailSender javaMailSender;

    public EmailService(JavaMailSender javaMailSender) {
        this.javaMailSender = javaMailSender;
    }

    @Value("${jwt.email}")
    private String from;

    public boolean enviarEmail(String to, int codigo) {
        if (to.isEmpty()) {
            return false;
        } else {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom(from);
            message.setTo(to);
            message.setSubject("Código de verificação.");
            message.setText("Este é um e-mail automatico,\npor favor não responder.\nSeu código de verificação é:\n" + codigo);
            javaMailSender.send(message);
            return true;
        }

    }

}
