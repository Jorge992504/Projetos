import database from "../database/database.js";

async function relacionarDoenca(req, res) {
    console.log(req.body);
    const doencas = req.body; //  [1,2,3,4,5,6] 
    await Promise.all(doencas.map(async d => {
        await database.query("insert into usuario_doenca (id_usuario, id_doenca) values ($1,$2)", [req.id, d]);
    }));
    return res.status(200).send("Relação feita com sucesso");
}

async function deletarDoenca(req, res) {
    const { id } = req.params;
    await database.query("delete from usuario_doenca where id_usuario = $1 and id_doenca = $2;", [req.id, id]);
    return res.send("Relação deletada");
}

export default { relacionarDoenca, deletarDoenca };