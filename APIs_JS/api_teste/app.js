import express, { request } from "express";
import routers from "./routes/routes.js";
import socket from "./ServerS/server_socket.js";
import { createServer } from "node:http";
import schedule from "node-schedule";
import emails from "./emails/email.js";



const app = express()
app.use(express.json())
app.use(routers)

const server = createServer(app);
socket(server);



server.listen(4000, () => {
    console.log('')
    console.log('|--------------------------------|')
    console.log('| API rodando na porta 4000      |')
    console.log('|--------------------------------|')
    console.log('')
});


// schedule.scheduleJob('*/5 * * * * *', async() => {
//     await emails.sendEmail();
// });

