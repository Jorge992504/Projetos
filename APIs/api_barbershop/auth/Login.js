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
    const { email, password } = req.body;
    
   
    if (!email || !password) {
        return res.status(400).send({ error: "Usuario ou senha não informado" });
    }

    let usuarios = await database.query("SELECT * FROM users where email = $1", [email]);
    if (!usuarios.rows.length) {
        return res.status(400).send({ error: "Usuário não encontrado" });
    }
    usuarios = usuarios.rows[0];
    
    if (bcrypt.compareSync(password, usuarios.password)) {
        const token = Jwt.sign({ id: usuarios.id, email: usuarios.email, profile: usuarios.profile }, process.env.SECRET_KEY, { algorithm: "HS256" });
        
        res.send({ token });
    } else {
        res.status(400).send({ error: "Senha errada" });
    }
}

export default Login;