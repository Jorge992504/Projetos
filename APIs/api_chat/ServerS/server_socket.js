
import { WebSocketServer } from 'ws';
import database from '../Data/database.js';

const clients = new Map(); // Armazena os clientes conectados

function onConnection(ws) {
  ws.on('message', async (message) => {
    let messageString = message.toString();
    try {
      const msg = JSON.parse(messageString);
      

      const user = (await database.query("select * from users where id = $1;",[msg.senderId])).rows;
      if (!user) {
        console.log('Usuário não cadastrado');
      }
        clients.set(msg.senderId, ws);
        clients.set(msg.receiverId, ws);
        ws.userId = msg.senderId;
      if (ws.userId) {
         console.log('Cliente conectado');
      }
      //
      // msg.senderId
      // msg.receiverId
      // msg.text 
      //

      
      ws.recipientId = clients.get( msg.receiverId);
      try {
        if (ws.recipientId) {
          const timestamp = new Date();
          await database.query(
            `INSERT INTO messages (sender_id, receiver_id, text, created_at, status) 
             VALUES ($1, $2, $3, $4, $5) RETURNING *`,
            [msg.senderId, msg.receiverId, msg.text, timestamp, 'enviado']
          );
          ws.recipientId.send(
            JSON.stringify({
              to: msg.senderId,
              from: msg.receiverId,
              content: msg.text,
              created_at: timestamp,
            })
          );
          console.log("Mensage enviado");
        }
        
      } catch (error) {
        console.error("Error: ",error);
      }
      
    } catch (error){
console.log("Erro ao enviar mensagem");
    }},);
  

  // Remove o cliente ao desconectar
  ws.on('close', () => {
    
    if (ws.userId) {
      delete clients[ws.userId];
      console.log(`Cliente ${ws.userId} desconectado.`);
    }
  });
}
  
export default () => {
    const wss = new WebSocketServer({
        port: 3001
    });
    
    wss.on('connection', onConnection);




    console.log('')
    console.log('|-------------------------------------------|')
    console.log('| Socket Server iniciado na porta 2001      |')
    console.log('|-------------------------------------------|')
    console.log('')
}
