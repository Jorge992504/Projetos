import express from "express";
import database from "../../Data/database.js";
import bcrypt from "bcrypt";

const router = express.Router()



async function get(req, res) {
    try {
        const id = req.id;
        let user = (await database.query(`select * from Users where id = $1;`,[id]));
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
        const {name, email, password} = req.body;
        const generateCode = () => Math.floor(1000 + Math.random() * 9000); 
        const code = generateCode();
        const data = new Date();
        let user = (await database.query(`select id from Users where email = $1;`, [email]));
        if (user.rows.length) {
            return res.status(400).send({error: "Status: 400, Usuário já cadastrado"});
        }else{
            const passwordNew = await bcrypt.hash(password, 10);
            await database.query(`insert into Users (name, email, password, confirmation, code) values ($1, $2, $3, $4, $5) RETURNING id, password;`, [name, email, passwordNew, 'false', code]);
            

            try {
                
                let emails = await database.query("select email from sendemail where email = $1;",[email]);
                if (emails.rows.length) {
    
                    return res.status(400).send({error: "Status 400, email ja cadastrado"});
                }else{
                    await database.query("INSERT INTO sendemail (email, status,code, created_at) VALUES ($1, $2, $3, $4);",
                    [email, 'Pendente',code, data]);
                return res.status(200).send('E-mail cadastrado com sucesso');
                }
            } catch (error) {
                console.error('Erro ao cadastrar o e-mail', 'erro: ', error);
                console.log('Message do erro: ', error.message);
            }
            return res.status(200).send('Usuário cadastrado com sucesso');

        }
        
    } catch (error) {
        console.error('Erro ao cadastrar o usuário', 'erro: ', error);
        console.log('Message do erro: ', error.message);
    }
}

async function getUsers(req, res) {
    const id = req.id;
    try {
        
        let users = (await database.query(`select * from Users where id != $1 ;`,[req.id])).rows;
        res.send(users);
    } catch (error) {
        console.error('Não há usuários', 'erro: ', error);

    }
}

async function confirmationCode(req, res) {
    const id = req.id;
    const {codigo} = req.body;
    const code = (await database.query("select code from Users where id = $1;",[id])).rows;
    const dbCode = code[0].code;
    try {
        if (codigo !== dbCode) {
            await database.query("update users set confirmation = $1 where id = $2", ['true', id]);
            return res.status(400).send('Conta não verfificada');
        }
        return res.status(200).send('Conta confirmada')
    } catch (error) {
        console.error('Conta não confirmada', 'erro: ', error);
    }
}

async function addRequest(req, res) {
    const id = req.id;
    const {user_id} = req.body;
     try {
        
       const friend = await database.query('select request from friends where user_id = $1;',[user_id]);
       if (friend.rows.length > 0) {
           return res.status(400).send('Solicitação de amizade já cadastrada');
       }else{
           await database.query('insert into friends (user_id, request) values ($1, $2);',[user_id, id]);
           return res.status(200).send('Solicitação cadastrada');
       }
     } catch (error) {
        console.log('Solicitação não cadastrada');
        console.error('Erro: ',error.error);
        console.error('Message do erro: ',error.message);
     }
    
}

async function getRequest(req, res) {
    const id = req.id; 
    try {
        const request = (await database.query('select request from friends where user_id = $1;',[id])).rows;
        
        if (!request) {
          return res.status(400).send('Nenhuma solicitação encontrada');
        }else{
          const requestId = request.map(row => row.request);
          
          let requests = (await database.query('select * from users where id = ANY($1);',[requestId])).rows;
          res.status(200).json(requests);
        }
      } catch (error) {
        console.error('Erro ao buscar amigos');
        console.error('Erro:', error);
        console.error('Mensagem do erro:', error.message);
        res.status(500).send('Erro ao buscar solicitação');
      }
  }
  
async function aceptRequest(req, res) {
    const id = req.id;
    const {friend_id} = req.body;
    
    try {
        if (!id || !friend_id) {
            return res.status(400).json({ error: "ID e friend_id são obrigatórios." });
        }
        await database.query('UPDATE friends SET friend_id = $1, request = 0 where user_id = $2;',[friend_id,id]);
        res.status(200).json({ message: "Solicitação aceita com sucesso!" });
    } catch (error) {
        console.error("Erro ao aceitar solicitação:", error);
        res.status(500).json({ error: "Erro interno do servidor." });
    }
}

async function deletRequest(req, res) {
    const id = req.id;
    const {request} = req.body;

    try {
        if (!id || !request) {
            return res.status(400).send("Parâmetros inválidos");
        }
    
        const result = await database.query('DELETE from friends where user_id = $1 and request = $2;',[id,request]);
        if (result.rowCount === 0 ) {
            return res.status(404).send("Solicitação não encontrada");
        }
        res.send({message: 'Solicitação deletada com sucesso', delete: result.rows[0]});
    } catch (error) {
        console.error('A solicitação náo foi deletada', 'erro: ', error);
        console.log('Message do erro: ', error.message);
    }
}



async function getFriends(req, res) {
    const id = req.id;

    
    try {
      const friend = (await database.query('select friend_id from friends where user_id = $1;',[id])).rows;
      
      if (!friend) {
        return res.status(400).send('Nenhuma amizade encontrada');
      }else{
        const friendId = friend.map(row => row.friend_id);
        
        let friends = (await database.query('select * from users where id = ANY($1);',[friendId])).rows;
        
        res.status(200).json(friends);
      }
    } catch (error) {
      console.error('Erro ao buscar amigos');
      console.error('Erro:', error);
      console.error('Mensagem do erro:', error.message);
      res.status(500).send('Erro ao buscar amizade');
    }
  }
  


  async function deletFriends(req, res) {
    const id = req.id;
    const {friend_id} = req.body;
     try {
         if (!id || !friend_id) {
             return res.status(400).send("Parâmetros inválidos");
         }
    
         const result = await database.query('DELETE from friends where user_id = $1 and friend_id = $2;',[id,friend_id]);
         if (result.rowCount === 0 ) {
             return res.status(404).send("Amigo não encontrado");
         }
         res.send({message: 'Amizade deletada com sucesso', delete: result.rows[0]});
     } catch (error) {
         console.error('A amizade náo foi deletada', 'erro: ', error);
         console.log('Message do erro: ', error.message);
     }
}

export default {get, post, getUsers, confirmationCode, addRequest, getRequest, aceptRequest, deletRequest, getFriends, deletFriends}