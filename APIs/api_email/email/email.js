import nodemailer from "nodemailer";

import database from "../Data/database.js";



const transporter = nodemailer.createTransport({
    host: 'smtp.gmail.com',
    port: 587,
    secure: false,
    auth:{
        user: 'trabalhojava2024@gmail.com',
        pass: 'txfqmkwobtzugrqk',
    }
});

 async function sendEmail() {
    try {
        console.log('Buscando e-mails pendentes...');
        let emails = (await database.query("select email, text from email where status = 'Pendente' ORDER BY created_at ASC LIMIT 10;")).rows;
        if (emails.length === 0) {
            console.log('Nenhum e-mail pendente');
            return;
        }
    
        for (const email of emails){
            try {
                await transporter.sendMail({
                    from: 'HáWork <trabalhojava2024@gmail.com>',
                    to: email.email,
                    subject: 'Cadastro realizado', //aqui vai o assunto do email
                    // html: '<h1>Olá, seja Bem-vindo!</h1> <p>Este e-mail é automatico, por favor não respnder</p> <p>Código de acesso oa aplicativo: CÓDIGO</p>',
                    text: email.text,
                });
        
                console.log(`E-mail enviado com sucesso para ${email.email}`);
        
                await database.query("update email set status = $1, updated_at = NOW() where email = $2", ['Enviado', email.email]);

            } catch (error) {
                console.error(`Erro ao enviar e-mail para: ${email.email}`, error.message);
                await database.query("update email set status = $1, updated_at = NOW() where email = $2", ['Erro', email.email]);
            }
        }
    } catch (error) {
        console.error('Erro ao processar e-mails pendentes:', error.message);
    }
}


export default {sendEmail}

    
    
    



