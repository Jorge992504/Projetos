import * as express from "express";

import Produtos from "./controllers/Produtos.js";

import Login from "./auth/Login.js";
import Autenticar from "./auth/Autenticar.js";
import Usuarios from "./controllers/Usuarios.js";
import Formas_Pagamentos from "./controllers/Formas_Pagamentos.js";
import Ordem from "./controllers/Ordem.js";



const rota = express.Router();

rota.use("/public", express.static("./public"));

rota.post("/login", Login);

rota.route("/produtos")
    // .all(Autenticar)
    .get(Produtos.listarProdutos)
    
rota.route("/usuarios")
    .all(Autenticar)
    .get(Usuarios.getUsuarios)
    .post(Usuarios.registerUsuarios)

rota.route("/formas_pagamentos")
    // .all(Autenticar)
    .get(Formas_Pagamentos.listarFormasPagamentos)

rota.route("/orders")
    .all(Autenticar)
    .post(Ordem.saveOrdem)
    .get(Ordem.getOrdens)



export default rota;