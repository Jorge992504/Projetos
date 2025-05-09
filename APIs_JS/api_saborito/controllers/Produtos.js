import database from "../database/database.js";
// import bcrypt from "bcrypt";

async function listarProdutos(req, res) {
    let produtos = (await database.query("SELECT * FROM produtos;")).rows;
    produtos = produtos.map(produto => {
        if(produto.foto){
            produto.foto = "http://localhost:3000/public/" + produto.foto;
        }else{
            produto.foto = "http://localhost:3000/public/logo.png";
        }
        return produto;
    });
    
    
    
    
    res.send(produtos);
}



export default { listarProdutos };