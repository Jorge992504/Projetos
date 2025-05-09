import { request, response } from "express";
import database from "../database/database.js";
import bcrypt from "bcrypt";
import Jwt from "jsonwebtoken";

/**
 * 
 * @param {request} req 
 * @param {response} res 
 */
async function Login(req, res) {
    const { user, pass } = req.body;
    if (!user || !pass) {
        return res.status(400).send({ error: "Usuario ou senha não informado" });
    }

    let usuario = await database.query("SELECT * FROM usuario where usuario = $1", [user]);
    if (!usuario.rows.length) {
        return res.status(400).send({ error: "Usuário não encontrado" });
    }
    usuario = usuario.rows[0];
    console.log(usuario);
    if (bcrypt.compareSync(pass, usuario.senha)) {
        const token = Jwt.sign({ id: usuario.id, user: usuario.usuario, email: usuario.email }, process.env.SECRET_KEY, { algorithm: "HS256" });
        res.send({ token });
    } else {
        res.status(400).send({ error: "Senha errada" });
    }
}

export default Login;