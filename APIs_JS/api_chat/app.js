import express, { request } from "express";
import routers from "./routes/routes.js";
import socket from "./ServerS/server_socket.js";
import schedule from "node-schedule";
import emails from "./emails/email.js";



const app = express()



app.use(express.json())
app.use(routers)

app.listen(3000, () => {
    console.log('')
    console.log('|--------------------------------|')
    console.log('| API rodando na porta 3000      |')
    console.log('|--------------------------------|')
    console.log('')
});


schedule.scheduleJob('*/5 * * * * *', async () => {
    await emails.sendEmail();
});

socket();