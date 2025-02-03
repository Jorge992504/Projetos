import { request, response } from "express";
import bcrypt from "bcrypt";
import Jwt from "jsonwebtoken";
import database from  "../../Data/database.js";

/**
 * @param {request} req
 * @param {response} res
 */

async function Login(req, res) {
    try {
        const {email, password} = req.body;
        if (!email || !password) {
            return res.status(400).send({error: "Usuário ou senha não informado"});
        }
        let users = await database.query("select * from users where email = $1",[email]);
        if (!users.rows.length) {
            return res.status(400).send({ error: "Usuário não encontrado" });
        }
        users = users.rows[0];
        if (bcrypt.compareSync(password, users.password)) {
            const token = Jwt.sign({ id: users.id, email: users.email }, process.env.SECRET_KEY, { algorithm: "HS256" });//valores que vão dentro do token
            res.send({ token });
        } else {
            res.status(400).send({ error: "Senha errada" });
        }
    } catch (e) {
        console.error('Erro ao buscar usuário ', e);
    }
}

export default Login;