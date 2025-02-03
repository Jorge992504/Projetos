import database from "../database/database.js";
import bcrypt from "bcrypt";

async function listarUsuarios(req, res) {
    const id = req.id;
    let user = (await database.query("SELECT * FROM usuario where id = $1;", [id])).rows[0];
    
    if (user) {
        if(user.foto){
            user.foto = "http://localhost:3000/public/" + user.foto;
        }else{
            user.foto = "http://localhost:3000/public/logo.png";
        }
    }
    res.send(user);
}

async function cadastrarUsuarios(req, res) {
    // const users = await database.query("SELECT * FROM usuario;");
    // res.send(users.rows);
    const { user, senha, nm, sob, peso, alt, email, dt, doenca } = req.body;
    let usuario = await database.query("SELECT * FROM usuario where usuario = $1", [user]);
    if (usuario.rows.length) {
        return res.status(400).send({ error: "Usuário já cadastrado" });
    } else {
        const senhaNew = await bcrypt.hash(senha, 10);
        await database.query("Insert into usuario (usuario, senha, nome, sobrenome, peso, altura, email, datanascimento) values ($1,$2,$3,$4,$5,$6,$7,$8) RETURNING id,senha;", [user, senhaNew, nm, sob, peso, alt, email, dt]);
        return res.status(200).send("Usuário cadastrado com sucesso");
    }

}

async function alterarUsuario(req, res) {
    const { peso, email } = req.body;
    //let usuario = await database.query('select * from usuario where id = $1',[req.id]);
    await database.query("update usuario set peso = $1, email = $2 where id = $3", [peso, email, req.id]);
    res.status(200).send("Usuário elterado com sucesso");
}

export default { listarUsuarios, cadastrarUsuarios, alterarUsuario };