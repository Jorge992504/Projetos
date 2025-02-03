import database from "../database/database.js";


async function saveInprovements(req, res) {
   try {
     const { improvements } = req.body;
     const id = req.id;
     

     if (!improvements || improvements.length === 0) {
       return res.status(400).send('A lista de melhoras não pode estar vazia.');
     }
 
     if (!id) {
       return res.status(400).send('O ID do usuário é obrigatório.');
     }
    await database.query(
           'INSERT INTO plan_improvements (user_id, improvement) VALUES ($1, $2)',
           [id, improvements]
         );
       
 
     res.status(200).send('Melhoras cadastradas com sucesso!');
   } catch (error) {
     console.error('Erro ao salvar as melhoras:', error);
     res.status(500).send('Erro ao salvar as melhoras.');
   }
 }
 

export default { saveInprovements };






