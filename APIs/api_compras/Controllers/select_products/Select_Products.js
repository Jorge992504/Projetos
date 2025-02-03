import express from "express";
import database from "../../Data/database.js";


async function get(req, res) {
    try {
        const id = req.id;
        let select = (await database.query("select product_id from select_products where user_id = $1;", [id])).rows;
        if (!select) {
            return res.status(400).send("A lista de compras esta vazia");
        }else{
            const productIds = select.map(row => row.product_id);
            let products = (await database.query("SELECT * FROM products WHERE id = ANY($1);",[productIds])).rows;
            products = products.map(product => {
                if (product.foto) {
                    product.foto = "http://192.168.0.7:3333/public/"+ product.foto;
                }else{
                    product.foto = "http://192.168.0.7:3333/public/food.png";
                }
                return product;
            });
            res.send(products);
        }
    } catch (error) {
        console.error('A lista de compras esta vazia', 'erro: ', error);
        console.log('Message do erro: ', error.message);
    }
}

async function post(req, res) {
    try {
        const {product_id} = req.body;
        const id = req.id;
        if (!id || !product_id) {
            return res.status(400).send("Parâmetros inválidos");
        }
        let select = (await database.query("select * from select_products where user_id = $1 and product_id = $2;", [id, product_id]));
        if (select.rows.length) {
            return res.status(403).send('O produto já esta na lista');
        }else{
            let product = (await database.query("insert into select_products (user_id, product_id) values ($1, $2);", [id, product_id]));
            return res.status(200).send('O produto foi adicionado na lista');
        }
    } catch (error) {
        console.error('O produto náo foi adicionado à lista', 'erro: ', error);
        console.log('Message do erro: ', error.message);
    }
}

async function delet(req, res) {
    try {
        const {product_id} = req.body;
        const id = req.id;
        if (!id || !product_id) {
            return res.status(400).send("Parâmetros inválidos");
        }
        const result = (await database.query("DELETE from select_products where user_id = $1 and product_id = $2;", [id, product_id]));
        if (result.rowCount === 0) {
            return res.status(404).send("Produto não encontrado");
        }
        res.send({message: 'Produto deletado com sucesso', delete: result.rows[0]});
    } catch (error) {
        console.error('O produto náo foi deletado à lista', 'erro: ', error);
        console.log('Message do erro: ', error.message);
    }
}

async function postNewProduct(req, res) {
    try {
        const {name} = req.body;
        const id = req.id;
        if (!name) {
            return res.status(400).send("Parâmetros inválidos");
        }
        await database.query("insert into products (name) values ($1);", [name]);
        let newProduct = await database.query("select id from products where name = $1",[name]);
        // let newProduct = await database.query("select id from products where name = $1", [name]);
        if (newProduct.rows.length > 0) {
            const idN = newProduct.rows[0].id;
            (await database.query("insert into select_products (user_id, product_id) values ($1, $2);", [id, idN]));
            return res.status(200).send('O produto foi adicionado na lista');
        }else{
            return res.status(400).send("Parâmetros inválidos");
        }
    } catch (error) {
        console.error('O produto náo foi adicionada na lista', 'erro: ', error);
        console.log('Message do erro: ', error.message);
    }
    
    
}


export default {get, post, delet, postNewProduct}