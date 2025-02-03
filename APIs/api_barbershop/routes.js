import * as express from "express";



import Login from "./auth/Login.js";
import Autenticar from "./auth/Autenticar.js";
import Usuarios from "./controllers/Usuarios.js";

import Ordem from "./controllers/Barbershop.js";
import Barbershop from "./controllers/Barbershop.js";



const rota = express.Router();

rota.use("/public", express.static("./public"));

rota.post("/login", Login);
rota.get("/login", Login);


rota.route("/usuarios")
    .post(Usuarios.registerUsuarios)
    .all(Autenticar)
    .get(Usuarios.getUsuarios)
    
rota.route("/barbershop")
    .all(Autenticar)
    .post(Barbershop.save)
    .get(Barbershop.getBabershop)



export default rota;