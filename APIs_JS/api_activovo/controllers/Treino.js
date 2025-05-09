import database from "../database/database.js";


async function listarTreino(req, res) {
    // const id = req.id;
    let treino = (await database.query("SELECT * FROM treino" ));
    
    
    res.send(treino.rows);
}



// async function alterarTreino(req, res) {
//     const { peco, email } = req.body;
//     //let usuario = await database.query('select * from usuario where id = $1',[req.id]);
//     await database.query("update usuario set peco = $1, email = $2 where id = $3", [peco, email, req.id]);
//     res.status(200).send("Usuário elterado com sucesso");
// }

async function deletarTreino(req, res) {
    const { id } = req.params;
    await database.query("delete from treino where id_usuario = $1 and id_treino = $2;", [req.id, id]);
    return res.send("Treino deletado");
}

export default { listarTreino, deletarTreino};