package jabpDev.ServicosPro.api.Services.WebSocket;


import jabpDev.ServicosPro.api.Dto.Request.RequestCategorias;
import jabpDev.ServicosPro.api.Dto.Request.RequestMessageDto;
import jabpDev.ServicosPro.api.Dto.Response.ResponseFoto;
import jabpDev.ServicosPro.api.Dto.Response.ResponseMessageDto;
import jabpDev.ServicosPro.api.Dto.Response.ResponseUsuarioPrestador;
import jabpDev.ServicosPro.api.Entitys.Categorias;
import jabpDev.ServicosPro.api.Entitys.Message;
import jabpDev.ServicosPro.api.Entitys.Usuario;
import jabpDev.ServicosPro.api.Exceptions.CustomExeception.CustomException;
import jabpDev.ServicosPro.api.Repositorys.RepositoryMessage;
import jabpDev.ServicosPro.api.Repositorys.RepositoryUsuario;
import jabpDev.ServicosPro.api.Services.Geral.ServicosGeral;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.io.*;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
public class ServiceMessage {

    private RepositoryMessage repositoryMessage;
    private ServicosGeral servicosGeral;
    private RepositoryUsuario repositoryUsuario;

    public List<ResponseMessageDto> buscarMessages(Long usuario){
        Usuario usuarioFrom = servicosGeral.getUsuario();
        Optional<Usuario> usuarioTo = repositoryUsuario.findById(usuario);
        if (!usuarioTo.isPresent()){
            throw new CustomException("Não foi possível enviar a mensagens");
        }
        List<ResponseMessageDto> messages = repositoryMessage.findByUsuarioFromAndUsuarioToOrderByDataTime(usuarioFrom.getId(), usuarioTo.get().getId());
        return messages.stream()
                .map(message -> {
                    return new ResponseMessageDto(
                            message.id(),
                            message.usuarioFrom(),
                            message.usuarioTo(),
                            message.message(),
                            message.dateTime(),
                            servicosGeral.getUrlInterna() + "messages" + "/" + message.id() + "/" + message.foto()
                    );
                }).collect(Collectors.toList());

    }

    public ResponseFoto salvarMessages(RequestMessageDto requestMessageDto)throws Exception{
        try {
            Usuario usuarioFrom = servicosGeral.getUsuario();
            Message message = new Message();
            Optional<Usuario> usuarioTo = repositoryUsuario.findById(requestMessageDto.usuarioTo());
            message.setUsuarioFrom(usuarioFrom);
            message.setUsuarioTo(usuarioTo.get());
            message.setMessage(requestMessageDto.message());
            message.setDateTime(requestMessageDto.dateTime());
            message.setFoto(requestMessageDto.foto() != null ? geraFoto(requestMessageDto.foto(), usuarioFrom.getId(), requestMessageDto.usuarioTo()) : null );
            Message response = repositoryMessage.save(message);
            if (response.getId() > 0){
                return new ResponseFoto(response.getFoto());
            }else{
                return new ResponseFoto(null);
            }
        }catch (Exception e){
            System.out.println("Não foi possível salvar as msg no banco: "+e.getMessage());
            return new ResponseFoto(null);
        }
    }

    private String geraFoto(String foto, Long usuarioFrom, Long usuarioTo)throws IOException{
        try{
            if (foto != null && !foto.isEmpty()) {
                String pastaUsuario = new File(servicosGeral.getUrlInterna() + usuarioFrom).getAbsolutePath();
                File directorioUsuario = new File(pastaUsuario);
                if (!directorioUsuario.exists()) {
                    boolean crearDirectorio = directorioUsuario.mkdirs();
                    if (!crearDirectorio) {
                        throw new CustomException("Não foi possível guardar a foto de perfil, Tente atualizar mais tarde.");
                    }
                }
                String pastaChat = new File(pastaUsuario + usuarioFrom + "-" + usuarioTo).getAbsolutePath();
                File directorioChat = new File(pastaChat);
                if (!directorioChat.exists()) {
                    boolean crearDirectorio = directorioChat.mkdirs();
                    if (!crearDirectorio) {
                        throw new CustomException("Não foi possível guardar a foto de perfil, Tente atualizar mais tarde.");
                    }
                }

                String nomeFoto = usuarioFrom + "-" + usuarioTo + ".png";
                File destino = new File(directorioChat, nomeFoto);
                String fotoBase64 = foto;
                if (fotoBase64.contains(",")) {
                    fotoBase64 = fotoBase64.split(",")[1];
                }
                byte[] fotoFinal = Base64.getDecoder().decode(fotoBase64);
                OutputStream stream = new FileOutputStream(destino);
                stream.write(fotoFinal);

                return nomeFoto;
            }else{
                return null;
            }
        }catch (IOException e){
            System.out.println(e.getMessage());
            return null;
        }
    }
}