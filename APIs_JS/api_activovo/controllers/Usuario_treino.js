import database from "../database/database.js";

async function relacionarUsuarioTreino(req, res) {
    // console.log(req.body);
    const dias = req.body; //  [1,2,3,4,5,6] 
    await Promise.all(dias.map(async d => {
        await database.query("insert into usuario_treino (id_usuario, id_treino) values ($1,$2)", [req.id, d]);
    }));
    return res.status(200).send("Relação feita com sucesso");
}
async function listarTreinoDia(req, res) {
    try {
        const {diaSemana} = req.params;
        console.log(diaSemana);
        const id = req.id;
        const exercicios = (await database.query(`SELECT e.*
                                                FROM exercicio e
                                                INNER JOIN treino_exercicio te ON e.id = te.id_exercicio
                                                INNER JOIN treino t ON te.id_treino = t.id
                                                INNER JOIN usuario_treino ut ON t.id = ut.id_treino
                                                WHERE ut.id_usuario = $1
                                                AND t.dia_semana = $2;`, [id, diaSemana]));
        console.log(exercicios.rows);
        return res.send(exercicios.rows);                                        
        
        } catch (e) {
            return res.status(400).send(e);
        }
        
        
}
// .rows.map(idE => idE.id)
async function listarTreinoUsuario(req, res) {
    
    let exercicios = (await database.query(`SELECT e.*
                                            FROM exercicio e
                                            INNER JOIN treino_exercicio te ON e.id = te.id_exercicio
                                            INNER JOIN treino t ON te.id_treino = t.id
                                            INNER JOIN usuario_treino ut ON t.id = ut.id_treino
                                            WHERE ut.id_usuario = $1
                                            AND t.dia_semana = $2;`, [req.id, diaSemana])).rows.map(idE => idE.id);
    
    
    
    res.send(exercicios.rows);
}

export default {relacionarUsuarioTreino, listarTreinoDia, listarTreinoUsuario}
