import express, { request } from "express";
import routers from "./routes/routes.js";
import schedule from "node-schedule";
import emails from "./email/email.js";
import socket from "./sockets/app.js";

const app = express()



app.use(express.json())
app.use(routers)

const server = app.listen(1111, () => {
    console.log('')
    console.log('|--------------------------------|')
    console.log('| Servidor rodando na porta 1111 |')
    console.log('|--------------------------------|')
    console.log('')
});


schedule.scheduleJob('*/1 * * * *', async () => {
    await emails.sendEmail();
});



// const rule = '* /1 * * * *';
// schedule.scheduleJob('*/1 * * * *', email.sendEmail);

socket();