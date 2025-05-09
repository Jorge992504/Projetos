import express from "express";
import database from "../../Data/database.js";
import bcrypt from "bcrypt";

const router = express.Router()

async function get(req, res) {
    try {
        const id = req.id;
        let user = (await database.query("select * from users where id = $1",[id]));
        if (!user) {
            return res.status(403).send({error:' Usuário não cadastrado'});
        }else{
            res.send(user.rows[0]);
        }
    } catch (error) {
        console.error('Usuário não encontrado', 'erro: ', error);
        console.log('Message do erro: ', error.message);
    }
    
}


async function post(req, res)  {
    try {
        const {name, email, password} = req.body
        let user = await database.query("select id from users where email = $1", [email]);
        if (user.rows.length) {
            return res.status(400).send({error: "Status: 400, Usuário já cadastrado"});
        }else{
            const passwordNew = await bcrypt.hash(password, 10);
            await database.query("insert into users (name, email, password) values ($1, $2, $3) RETURNING id, password;", [name, email, passwordNew]);
            return res.status(200).send('Usuário cadastrado com sucesso');
        }
    } catch (error) {
        console.error('Erro ao cadastrar o usuário', 'erro: ', error);
        console.log('Message do erro: ', error.message);
    }
    
}





export default {get, post}