import database from "../../Data/database.js"; 
import express from "express";
const router = express.Router();




async function getMessages(req, res) {
    try {
        const id = req.id;
        const {receiverId} = req.body;
        let messages = (await database.query(`select * from Messages where sender_id = $1 and receiver_id = $2;`,[id, receiverId])).rows;
        if (!messages) {
            return res.status(403).send({error:' Messagens não encontrados'});
        }else{
            res.send(messages);
        }
    } catch (error) {
        console.error('Messagens não encontrado', 'erro: ', error);
        console.log('Message do erro: ', error.message);
    }
}

export default {getMessages};
