import database from "../database/database.js";

async function relacionarExercicios(req,res){
    const { exercicios, beneficios } = req.body; // { "exercicios": [1,2,3,4,5,6] }
    await Promise.all(exercicios.map(async d => {
        await database.query("insert into exercicio_doenca (id_exercicio,id_doenca, beneficios) values ($1,$2)", [d,id,beneficios]);
    }));
    return res.status(200).send("Relação feita com sucesso");
}

async function deletarExercicio(req, res) {
    const { id_doenca,id_exercicio } = req.params;
    await database.query("delete from exercicio_doenca where id_doenca = $1 and id_exercicio = $2;", [id_doenca, id_exercicio]);
    return res.send("Relação deletada");
}

export default {relacionarExercicios, deletarExercicio};