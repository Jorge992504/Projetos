
import { WebSocketServer } from 'ws';
import database from '../Data/database.js';

const clients = {}; // Armazena os clientes conectados

function onConnection(ws) {
  ws.on('message', async (message) => {
    
    let messageString = message.toString();
    
    try {
      const msg = JSON.parse(messageString);
      

      const user = (await database.query("select * from users where id = $1;",[msg.senderId])).rows;
      console.log(user);

      // Configura o ID do cliente
      if (msg.senderId === 'sender_id') {
        clients[msg.senderId] = ws;
        ws.userId = msg.senderId;
        console.log(`Cliente ${msg.senderId} conectado.`);
      }

      // Envia mensagem para o destinatário
      if (msg.text === 'message') {
        const recipient = clients[msg.recipientId]; // Obtém a conexão do destinatário
        const timestamp = new Date(); // Data e hora atual

        // Salva a mensagem no banco de dados
        try {
          const result = await database.query(
            `INSERT INTO messages (sender_id, receiver_id, text, created_at, status) 
             VALUES ($1, $2, $3, $4, $5) RETURNING *`,
            [msg.senderId, msg.recipientId, msg.content, timestamp, 'enviado']
          );

          const savedMessage = result.rows[0];

          // Envia a mensagem ao destinatário se ele estiver online
          if (recipient) {
            recipient.send(
              JSON.stringify({
                type: 'message',
                content: savedMessage.text,
                from: savedMessage.sender_id,
                to: savedMessage.receiver_id,
                created_at: savedMessage.created_at,
              })
            );
          } else {
            console.log(`Destinatário ${msg.recipientId} não está conectado.`);
          }
        } catch (err) {
          console.error('Erro ao salvar mensagem:', err);
        }
      }
    } catch (err) {
      console.error('Erro ao processar mensagem:', err);
    }
  });

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
