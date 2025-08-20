package com.compras.api.services.dashboard;


import com.compras.api.api.dto.response.ResponseGastosDto;
import com.compras.api.api.dto.response.ResponseNfeDto;
import com.compras.api.api.exception.ErrorException;
import com.compras.api.api.models.Nfe;
import com.compras.api.api.models.Users;
import com.compras.api.api.repository.nfe.NfeRepository;
import com.compras.api.services.user.ServiceUser;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class DashBoardService {


    private final NfeRepository nfeRepository;
    private final ServiceUser serviceUser;

    public List<ResponseGastosDto> listarVlTotal(){
        List<ResponseGastosDto> dtos = new ArrayList<>();
        Users u = (Users) SecurityContextHolder.getContext().getAuthentication().getPrincipal(); //contexto para pegar o email do token
        Optional<Users> user = serviceUser.getUser(u.getEmail());
        if (user.isPresent()){
            return nfeRepository.somarPorMes(user.get().getId()).stream()
                    .map(e -> {
                        Integer ano = (Integer) e[0];
                        Integer mes = (Integer) e[1];
                        Double valor = (Double) e[2];
                        String date = String.format("%04d-%02d", ano, mes);
                        return new ResponseGastosDto(date, valor);
                    })
                    .toList();
        }else{
            throw new ErrorException("USER_NOT_FOUND",401,"Usuário não encontrado");
        }

    }
}
