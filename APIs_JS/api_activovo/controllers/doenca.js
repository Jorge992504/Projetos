import database from "../database/database.js";

async function listarDoencas(req, res) {

    let doenca = (await database.query("select * from doenca"));
    res.send(doenca.rows);
    
}

export default {listarDoencas};