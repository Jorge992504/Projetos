import database from "../database/database.js";

async function  saveOrdem(req, res){
    const {endereco, cpf, tipo_pagamento, produtos} = req.body;
    try {
        await Promise.all(produtos.map(async p => {
            const {id_produto,quantidade, total_preco, } = p;
            await database.query(`insert into ordem (id_produto, id_usuario, quantidade, total_preco, 
                endereco, cpf, tipo_pagamento) values ($1, $2, $3, $4, $5, $6, $7)`, [id_produto, req.id, quantidade, total_preco, endereco, cpf, tipo_pagamento]);
        }));
        return res.status(200).send("Ordem cadastrada com sucesso");
    } catch (error) {
        return res.status(200).send("Ordem cadastrada com sucesso");
    }
}

async function getOrdens(req, res) {
    let ordens = (await database.query("SELECT * FROM ordem;"));
    
    res.send(ordens.rows);
}

export default {saveOrdem, getOrdens};






