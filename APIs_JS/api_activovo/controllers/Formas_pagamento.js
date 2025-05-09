import database from "../database/database.js";

async function listarFormasPagamentos(req, res) {
    let formas_pagamentos = (await database.query("SELECT * FROM formas_pagamentos;"));
    console.log(formas_pagamentos);
    res.send(formas_pagamentos.rows);
}



export default { listarFormasPagamentos };