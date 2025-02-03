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
    try {
        const { email, password } = req.body;
        if (!email || !password) {
            return res.status(400).send({ error: "Usuario ou senha não informado" });
        }
    
        let usuario = await database.query("SELECT * FROM users where email = $1", [email]);
        if (!usuario.rows.length) {
            return res.status(400).send({ error: "Usuário não encontrado" });
        }
        usuario = usuario.rows[0];
        if (bcrypt.compareSync(password, usuario.password)) {
            const token = Jwt.sign({ id: usuario.id,  email: usuario.email, profile: usuario.profile }, process.env.SECRET_KEY, { algorithm: "HS256" });
            res.send({ token });
        } else {
            res.status(400).send({ error: "Senha errada" });
        }
    } catch (error) {
        console.error('Erro ao buscar usuário ','erro: ', error);
    }
}

export default Login;