import database from "../Data/database.js";
import Jwt from "jsonwebtoken";
import { Server, Socket } from 'socket.io';

/**
 * @type {Server}
 */
let io;

export default (server) => {
  io = new Server(server);
  io.on('connection', onConnection);

}

let clients = {}; // Armazena os clientes conectados

/**
 * 
 * @param {Socket} socket 
 */
async function onConnection(socket) {
  const headers = socket.request.headers.authorization;
  if (headers == null) {
    socket.disconnect();
  }
  const auth = headers.split(" ")[1];
  // console.log(auth);
  const token = Jwt.decode(auth);
  const sender = token.id;

  console.log('Usuário conectado ', sender);
  console.log('Socket id: ', socket.id);


  await database.query('update Users set socket_id = $1 where id = $2;', [socket.id, sender]);

  socket.on("mensagem", async (msg) => {
    console.log(msg);

    const receiver = (await database.query('select socket_id from users where id = $1;', [msg.receiverId])).rows[0];
    if (!receiver) {
      console.log("receiver======> ", receiver);
      console.log("receiverid======> ", msg.receiverid);
      return;
    };

    let cliente = io.sockets.sockets.get(receiver.socket_id);
    const date = new Date();
    if (!cliente) {
      await database.query('insert into Messages (sender_id, receiver_id, text, created_at, status) values ($1, $2, $3, $4, $5);', [sender, msg.receiverId, msg.text, date, 'pendente']);
    } else {
      await database.query('insert into Messages (sender_id, receiver_id, text, created_at, status) values ($1, $2, $3, $4, $5);', [sender, msg.receiverId, msg.text, date, 'pendente']);
      cliente.emit("mensagem", { msg: msg.text, msg: msg.receiverId });
      socket.emit("mensagem", { msg: msg.text, msg: msg.receiverId });
      console.log('Mensagem envidada');
    }

  });


  socket.on("disconnect", async () => {
    try {

      await database.query(`UPDATE users SET socket_id = NULL WHERE id = $1;`, [sender]);
      // socket.disconnect();
      console.log(`Usuário ${token.id} desconectado`);



    } catch (error) {
      console.log("Usuário não desconectado");
    }
  });



}