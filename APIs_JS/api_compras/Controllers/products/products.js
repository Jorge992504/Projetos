import express from "express";
import database from "../../Data/database.js";



async function get(req, res) {
    
    const { name } = req.query;
    try {
        
        let products = (await database.query("select * from products;")).rows;
        products = products.map(product => {
            if (product.foto) {
                product.foto = "http://192.168.0.7:3333/public/" + product.foto;
            }else{
                product.foto = "http://192.168.0.7:3333/public/food.png";
            }
            return product;
        });
        
        res.send(products);
    } catch (error) {
        console.error('Produtos não encontrados', 'erro: ', error);
        console.log('Message do erro: ', error.message);
    }
}

async function search(req, res) {
    try {
        const { query } = req.body;
        let products = (await database.query("select name from products where name LIKE $1;", [`${query}%`])).rows;
        if (!products) {
            let product = (await database.query("insert into products (name, foto) values ($1, $2);", [query]));
            res.send(product.rows);
        } else {
            res.send(products);
        }
    } catch (error) {
        console.error('Produtos não encontrados', 'erro: ', error);
        console.log('Message do erro: ', error.message);
    }
}

export default { get, search }