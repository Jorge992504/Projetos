import database from "../database/database.js";



async function CriarTreino(req, res) {
    try {
        // console.log(req.id);
        // [{ id_exercicio: 1 }, { id_exercicio: 2 }, { id_exercicio: 3 },] -> [1, 2, 3]
        let idExercicios = (await database.query(`select de.id_exercicio as id from usuario_doenca as ud
                                                inner join doenca_exercicio as de ON de.id_doenca = ud.id_doenca	
                                                where ud.id_usuario = $1`, [req.id])).rows.map(idE => idE.id);
        if (idExercicios.length === 0) {
        //Se o usuário não tiver doenças, selecionar exercícios aleatórios
           idExercicios = (await database.query("select id from exercicio order by random() LIMIT 2")).rows.map(e => e.id);
        }
                                                        
        // console.log(idExercicios);
        let idTreino = (await database.query(`select ut.id_treino as id 
                                                from usuario_treino as ut 
                                                where ut.id_usuario = $1 `, [req.id])).rows.map(idT => idT.id);

        // console.log(idTreino);
        const totalExe = idTreino.length * 4;

        if (idExercicios.length < totalExe) {
            let falta = idExercicios.length - totalExe.length;
            const exercicios = (await database.query("select id from exercicio where id not in ($1) order by random() LIMIT $2", [idExercicios, falta])).rows.map(e => e.id);
            idExercicios.push(...exercicios);
        }
        let index = 0;
        await Promise.all(idTreino.map(async t => {
            if ((index + 4) > idExercicios.length) {
                return;
            }
            let exec = idExercicios.slice(index, (index + 4))

            await Promise.all(exec.map(async ex => {
                await database.query("insert into treino_exercicio (id_treino, id_exercicio) values ($1, $2)", [t, ex]).rows;
            }))

            index += 4;
        }));
        return res.status(200).send("Relação feita com sucesso");
    } catch (e) {
        return res.status(400).send(e)
    }

}

async function listarTreinoSemana(req, res) {
    
    
    
        let treino = (await database.query(`SELECT 
                                                t.*
                                                FROM 
                                                usuario_treino ut
                                                JOIN 
                                                treino t ON ut.id_treino = t.id
                                                WHERE 
                                                ut.id_usuario = $1`, [req.id])).rows.map(idT => idT.id);
        
         
        res.send(treino.rows);
    
}

async function alterarTreino(req, res) {
    const { id } = req.body;
    await database.query("update treino set id_treino = $1 where id = $2", [id, req.id]);
    res.status(200).send("Treino elterado com sucesso");
}

async function deletartreino(req, res) {
    const { id } = req.params;
    await database.query("delete from treino where id_usuario = $1 and id_treino = $2;", [req.id, id]);
    return res.send("Relação deletada");
}

export default { CriarTreino, alterarTreino, deletartreino,listarTreinoSemana};