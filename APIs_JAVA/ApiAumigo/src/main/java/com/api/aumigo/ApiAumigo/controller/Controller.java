package com.api.aumigo.ApiAumigo.controller;


import com.api.aumigo.ApiAumigo.exceptions.ErrorExeception;
import com.api.aumigo.ApiAumigo.models.Users;
import com.api.aumigo.ApiAumigo.repository.UserRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/controller")
public class Controller {
    private final UserRepository userRepository;

    public Controller(UserRepository userRepository){
        this.userRepository = userRepository;
    }

    @GetMapping
    public ResponseEntity<List<Users>> getUsers(){
        try{
            List<Users> users = userRepository.findAll();
            return ResponseEntity.ok(users);
        }catch (Exception e){
            throw new ErrorExeception(e);
        }

    }


}
