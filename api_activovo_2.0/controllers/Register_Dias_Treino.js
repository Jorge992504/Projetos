import database from "../database/database.js";


async function saveDays(req, res) {
   try {
     const { days } = req.body;
     const id = req.id;
 
     if (!days || days.length === 0) {
       return res.status(400).send('A lista de dias não pode estar vazia.');
     }
 
     if (!id) {
       return res.status(400).send('O ID do usuário é obrigatório.');
     }
 
     // Iterar sobre os dias e inserir treinos
     for (const day of days) {
       // Obter 4 exercícios aleatórios
       const resultExe = await database.query('SELECT id FROM exercise ORDER BY RANDOM() LIMIT 4');
 
       if (resultExe.rows.length === 0) {
         return res.status(404).send('Nenhum exercício encontrado.');
       }
 
       // Inserir cada exercício para o usuário no dia correspondente
       for (const exercise of resultExe.rows) {
         await database.query(
           'INSERT INTO training (user_id, exercise_id, days) VALUES ($1, $2, $3)',
           [id, exercise.id, day]
         );
       }
     }
 
     res.status(200).send('Dias cadastrados com sucesso!');
   } catch (error) {
     console.error('Erro ao salvar os dias de treinamento:', error);
     res.status(500).send('Erro ao salvar os dias de treinamento.');
   }
 }
 

export default { saveDays };