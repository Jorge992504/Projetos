package com.jabpdev.cadastro_usuario.services;


import com.jabpdev.cadastro_usuario.infra.entitys.Usuario;
import com.jabpdev.cadastro_usuario.infra.repositorys.UsuarioRepository;
import org.springframework.stereotype.Service;
//contrutor na mao
@Service

public class UsuarioService {
    private UsuarioRepository usuarioRepository;

    public UsuarioService(UsuarioRepository usuarioRepository) {
        this.usuarioRepository = usuarioRepository;
    }

    public void salvarUsuario(Usuario usuario){
        usuarioRepository.saveAndFlush(usuario);
    }

    public Usuario buscarUsuarioPorEmail(String email){
        return usuarioRepository.findByEmail(email).orElseThrow(()-> new RuntimeException("E-mail não encontrado"));
    }

    public void deletarUsuarioPorEmail(String email){
        usuarioRepository.deleteByEmail(email);
    }

    public void atualizarUsuarioPorIde(Long id, Usuario usuarioBody){
        Usuario usuarioEntity = usuarioRepository.findById(id).orElseThrow(()-> new RuntimeException("usuário não encontrado"));
        Usuario usuarioAtualizado = Usuario.builder()
                .email(usuarioBody.getEmail()!= null ? usuarioBody.getEmail() : usuarioEntity.getEmail())
                .nome(usuarioBody.getNome() != null ? usuarioBody.getNome() : usuarioEntity.getNome())
                .id(usuarioEntity.getId())
                .build();
        usuarioRepository.saveAndFlush(usuarioAtualizado);
    }
}
