const nodemailer = require('nodemailer');


const transport = nodemailer.createTransport(
    {
        host: 'smtp.gmail.com',
        port: 465,
        secure: true,
        auth: {
            user: 'trabalhojava2024@gmail.com',
            pass: 'txfqmkwobtzugrqk',
        }
    }
);

(async () => {
    try {
        await transport.sendMail({
            from: 'Teste de email <trabalhojava2024@gmail.com>',
            to: 'jorgeabp99@gmail.com',
            subject: 'Primeiro teste', //aqui vai o assunto do email
            // html: '<h1>Olá, seja Bem-vindo!</h1> <p>Este e-mail é automatico, por favor não respnder</p> <p>Código de acesso oa aplicativo: CÓDIGO</p>',
            text: 'Olá, seja Bem-vindo!. Este e-mail é automatico, por favor não respnder. Código de acesso oa aplicativo: CÓDIGO',
        })
        console.log("Sucesso")
    } catch (e) {
        console.error(e)
    }
})();

// .then((response) => console.log('E-mail enviado com sucesso!'))
// .catch((err)=> console.log('Erro ao enviar e-mail: ',err));