import database from "../database/database.js";
import bcrypt from "bcrypt";

async function getUsuarios(req, res){
    const email = req.email;
    let usuarios = (await database.query("SELECT * FROM users where email = $1;", [email])).rows[0];
    // usuarios = usuarios.map(usuario => {
    //         if(usuario.foto){
    //             usuario.foto = "http://localhost:3000/public/" + usuario.foto;
    //         }else{
    //             usuario.foto = "http://localhost:3000/public/logo.png";
    //         }
    //         return usuario;
    //     });
        res.send(usuarios);
}

async function registerUsuarios(req, res) {
    
    const {name, email, password, profile } = req.body;
    
    let usuarios = await database.query("SELECT * FROM users where email = $1", [email]);
    if (usuarios.rows.length) {
        return res.status(400).send({ error: "Usuário já cadastrado" });
    } else {
        const senhaNew = await bcrypt.hash(password, 10);
        await database.query("Insert into users (email, name, password, profile) values ($1,$2,$3,$4) RETURNING id,password;", [email, name, senhaNew, profile]);
        return res.status(200).send("Usuário cadastrado com sucesso");
    }

}

export default {getUsuarios, registerUsuarios};
