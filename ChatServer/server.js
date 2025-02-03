

// const express = require('express');
// const http = require('http');
// const socketIo = require('socket.io');
// const jwt = require('jsonwebtoken');

// const app = express();
// const server = http.createServer(app);
// const io = socketIo(server);

// const SECRET_KEY = 'SECRET_KEY'; // Mantenha a mesma chave usada no cliente

// let clients = {}; // Armazenar os clientes conectados e seus respectivos nomes

// io.use((socket, next) => {
//     const token = socket.handshake.auth.token;
//     if (!token) {
//         return next(new Error('Token ausente'));
//     }
//     try {
//         const payload = jwt.verify(token, SECRET_KEY);
//         socket.user = payload; // Salva os dados do usuário autenticado no socket
//         clients[socket.id] = socket.user.name; // Armazenar nome no objeto clients
//         next();
//     } catch (err) {
//         console.log('Token inválido:', err.message);
//         return next(new Error('Token inválido'));
//     }
// });

// io.on('connection', (socket) => {
//     console.log(`Cliente conectado: ${socket.id}`);

//     // Notificar todos os clientes conectados sobre o novo cliente
//     io.emit('clientsList', Object.values(clients)); // Enviar lista atualizada para todos os clientes

//     // Enviar mensagem para clientes específicos
//     socket.on('sendMessage', (data) => {
//         const senderName = data.senderName;  
//         const msg = data.msg;
//         const targetId = data.targetId;

//         if (targetId && clients[targetId]) {
//             // Enviar para um cliente específico
//             io.to(targetId).emit('receberMessage', { senderName, msg });
//             console.log(`Mensagem enviada para ${targetId}: ${msg}`);
//         } else {
//             // Enviar para todos
//             socket.broadcast.emit('receberMessage', { senderName, msg });
//             console.log(`Mensagem para todos: ${msg}`);
//         }
//     });

//     // Desconectar cliente
//     socket.on('disconnect', () => {
//         delete clients[socket.id];
//         console.log(`Cliente desconectado: ${socket.id}`);
//         io.emit('clientsList', Object.values(clients)); // Atualiza lista de clientes
//     });
// });

// server.listen(2000, () => {
//     console.log('Servidor escutando na porta 2000');
// });



const express = require('express');  
const http = require('http');  
const socketIo = require('socket.io');  
const jwt = require('jsonwebtoken');  

const app = express();  
const server = http.createServer(app);  
const io = socketIo(server);  

const SECRET_KEY = 'SECRET_KEY'; // Mantenha a mesma chave usada no cliente  

let clients = {}; // Armazenar os clientes conectados e seus respectivos nomes  

io.use((socket, next) => {  
    const token = socket.handshake.auth.token;  
    if (!token) {  
        return next(new Error('Token ausente'));  
    }  
    try {  
        const payload = jwt.verify(token, SECRET_KEY);  
        socket.user = payload; // Salva os dados do usuário autenticado no socket  
        clients[socket.id] = socket.user.name; // Armazenar nome no objeto clients  
        next();  
    } catch (err) {  
        console.log('Token inválido:', err.message);  
        return next(new Error('Token inválido'));  
    }  
});  

io.on('connection', (socket) => {  
    console.log(`Cliente conectado: ${socket.id}`);  

    // Notificar todos os clientes conectados sobre o novo cliente  
    io.emit('clientsList', Object.values(clients)); // Enviar lista atualizada para todos os clientes  

    // Enviar mensagem para clientes específicos  
    socket.on('sendMessage', (data) => {  
        const senderName = data.senderName;  
        const msg = data.msg;  
        const targetId = data.targetId;  

        if (targetId && clients[targetId]) {  
            // Enviar para um cliente específico  
            io.to(targetId).emit('receberMessage', { senderName, msg });  
            console.log(`Mensagem enviada para ${targetId}: ${msg}`);  
        } else {  
            // Enviar para todos  
            socket.broadcast.emit('receberMessage', { senderName, msg });  
            console.log(`Mensagem para todos: ${msg}`);  
        }  
    });  

    // Lidar com transmissão de dados de vídeo  
    socket.on('videoData', (data) => {  
        // Enviar dados de vídeo para todos os outros clientes  
        socket.broadcast.emit('videoStream', data);  
    });  

    // Desconectar cliente  
    socket.on('disconnect', () => {  
        delete clients[socket.id];  
        console.log(`Cliente desconectado: ${socket.id}`);  
        io.emit('clientsList', Object.values(clients)); // Atualiza lista de clientes  
    });  
});  

server.listen(2000, () => {  
    console.log('Servidor escutando na porta 2000');  
});