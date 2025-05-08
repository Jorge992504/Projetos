package com.jorge.ws.model;


import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


//################################
//Estrutura das messages
//###############################




@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class MsgDto {
    private String to;
    private String msg;
}
