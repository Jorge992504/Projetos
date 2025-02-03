import database from "../database/database.js";


/**
 * 
 * @param {import("express").Request} req 
 * @param {*} res 
 * @returns 
 */
async function getTraining(req, res) {
    try {
      const id = req.id; 
      const { weekday } = req.params; 

      
      if (!id || !weekday) {
        return res.status(400).send("O ID do usuário e o dia da semana são obrigatórios.");
      }
  
      
      const result = await database.query(
        `
        SELECT e.* 
        FROM training t
        INNER JOIN exercise e ON t.exercise_id = e.id
        WHERE t.user_id = $1 AND t.days = $2;
        `,
        [id, weekday]
      );
  
      
      if (result.rows.length === 0) {
        return res.status(404).send("Nenhum exercício encontrado para o usuário nesse dia.");
      };

  
    if (result.video) {
        result.video = "http://localhost:3000/public/" + result.video;
    }else{
        result.video = "http://localhost:3000/public/teste.pm4";
    };
      
      res.status(200).send(result.rows);
    } catch (error) {
      console.error("Erro ao buscar os treinos: ", error);
      res.status(500).send("Erro ao buscar os treinos.");
    }
  }

  async function getTrainingVip(req, res) {
    try {
      const id = req.id; 
      const { weekday } = req.params; 
      if (!id || !weekday) {
        return res.status(400).send("O ID do usuário e o dia da semana são obrigatórios.");
      }
  
      
      const result = await database.query(
        `
        SELECT e.* 
        FROM training_vip t
        INNER JOIN exercise_vip e ON t.exercise_id = e.id
        WHERE t.user_id = $1 AND t.days = $2;
        `,
        [id, weekday]
      );
  
      
      if (result.rows.length === 0) {
        return res.status(404).send("Nenhum exercício encontrado para o usuário nesse dia.");
      };

  
    if (result.video) {
        result.video = "http://localhost:3000/public/" + result.video;
    }else{
        result.video = "http://localhost:3000/public/teste.pm4";
    };
      
      res.status(200).send(result.rows);
    } catch (error) {
      console.error("Erro ao buscar os treinos: ", error);
      res.status(500).send("Erro ao buscar os treinos.");
    }
  }
  

export default { getTraining, getTrainingVip};