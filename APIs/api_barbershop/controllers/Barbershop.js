import database from "../database/database.js";

async function save(req, res) {  
    try {  
        const  {openig_days} = req.body;
        const  {opening_hours} = req.body;
        const  {name} = req.body;
        const  {email} = req.body;
        await Promise.all(openig_days.map(async (d) => {
            await Promise.all(opening_hours.map(async (h) => {
                await database.query(`insert into barber_shop (user_id, name, email, opening_days, opening_hours) values ($1,$2,$3,$4,$5)`, [req.id, name, email, d, h]);
            }));
         }));   
         return res.status(200).send('Barbearia cadastrada com sucesso'); 
    } catch (error) {  
        console.error('Erro ao cadastrar a barbearia:', error);  
        return res.status(500).send('Erro ao cadastrar a barbearia');  
    }  
} 

async function getBabershop(req, res) {
    try {
        const userId = req.id;
        const colavorador  = (await database.query("select * from usuarios where user_id = $1;", [userId])).rows;
        res.send(colavorador);
    } catch (error) {
        console.error('Erro ao buscar a barbearia:', error);  
        return res.status(500).send('Erro ao buscar a barbearia');
    }
}

export default {save, getBabershop};






