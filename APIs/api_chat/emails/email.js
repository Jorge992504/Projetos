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
        console.log('Buscando e-mails pendentes....');
        let emails = (await database.query("select email, text, code from sendemail where status = 'Pendente' ORDER BY created_at ASC LIMIT 10")).rows;
        if (emails.length === 0) {
            console.log('Nenhum e-mail encontrado');
            return;
        }
        
        for(const email of emails){
            try {
                if (!email.code) {
                    await transporter.sendMail({
                        from: 'Equipe de HomeChat <trabalhojava2024@gmail.com>',
                        to: email.email,
                        subject: 'Convite de chat',
                        text: `Olá, você recebeu um convite para cadastra-se no nosso App!\n\n${email.text}\n\nAtenciosamente, Equipe HomeChat`,
                    });
                    console.log(`E-mail enviado com sucesso para ${email.email}`);
                    await database.query("DELETE FROM sendemail WHERE email = $1", [email.email]);        
                    // await database.query("update sendemail set status = $1, updated_at = NOW() where email = $2", ['Enviado', email.email]);                    
                }else{
                    await transporter.sendMail({
                        from: 'Equipe de HomeChat <trabalhojava2024@gmail.com>',
                        to: email.email,
                        subject: 'Código de verificação',
                        text: `Olá, você recebeu o código de confirmação!\n${email.code}\nAtenciosamente, Equipe HomeChat`,
                    });
                    console.log(`E-mail enviado com sucesso para ${email.email}`);
                    await database.query("DELETE FROM sendemail WHERE email = $1", [email.email]);
                    
                }
                
            } catch (error) {
                console.error(`Erro ao enviar e-mail para: ${email.email}`, error.message);
                await database.query("update sendemail set status = $1, updated_at = NOW() where email = $2", ['Erro', email.email]);
            }
        }
} catch (error) {
    console.error('Erro ao processar e-mails pendentes:', error.message);
}

}


async function saveEmail(req, res) {
    // const generateCode = () => Math.floor(1000 + Math.random() * 9000); 
    // const code = generateCode();
    const {email, text} = req.body;
    const data = new Date();
    try {
        let emails = await database.query("select email from sendemail where email = $1;",[email]);
        if (emails.rows.length) {
            return res.status(400).send({error: "Status 400, email ja cadastrado"});
        }else{
            await database.query("INSERT INTO sendemail (email, text, status, created_at) VALUES ($1, $2, $3, $4);",
      [email, text, 'Pendente', data]);
            return res.status(200).send('E-mail cadastrado com sucesso');
        }
    } catch (error) {
        console.error("Erro ao salvar e-mail:", error);
        return res.status(500).send({ error: "Erro interno no servidor" });
    }
    
}


export default {sendEmail,saveEmail}