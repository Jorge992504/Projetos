import database from "../database/database.js";
import bcrypt from "bcrypt";

async function getUsuarios(req, res){
    let usuarios = (await database.query("SELECT * FROM usuarios;")).rows;
    usuarios = usuarios.map(usuario => {
            if(usuario.foto){
                usuario.foto = "http://localhost:3000/public/" + usuario.foto;
            }else{
                usuario.foto = "http://localhost:3000/public/logo.png";
            }
            return usuario;
        });
        res.send(usuarios);
}

async function registerUsuarios(req, res) {
    
    const { email, nome, senha } = req.body;
    
    let usuarios = await database.query("SELECT * FROM usuarios where email = $1", [email]);
    if (usuarios.rows.length) {
        return res.status(400).send({ error: "Usuário já cadastrado" });
    } else {
        const senhaNew = await bcrypt.hash(senha, 10);
        await database.query("Insert into usuarios (email, nome, senha) values ($1,$2,$3) RETURNING id,senha;", [email, nome, senhaNew]);
        return res.status(200).send("Usuário cadastrado com sucesso");
    }

}

export default {getUsuarios, registerUsuarios};
