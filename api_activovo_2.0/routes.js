import * as express from "express";
import Usuario from "./controllers/Usuario.js";
import Login from "./auth/Login.js";
import Autenticar from "./auth/Autenticar.js";


import Register_Dias_Treino from "./controllers/Register_Dias_Treino.js";
import Register_Dias_Treino_Doencas from "./controllers/Register_Dias_Treino_Doencas.js";
import Training from "./controllers/Training.js";
import Plan_Improvements from "./controllers/Plan_Improvements.js";




const rota = express.Router();

rota.use("/public", express.static("./public"));

rota.post("/login", Login);

rota.route("/user")
    .get(Usuario.getUsers);

//informações do usuário
rota.route("/users")
    .post(Usuario.saveUsers)
    .all(Autenticar)
    .get(Usuario.getUser)
    .patch(Usuario.modifyUser);



//cadastrar usuario sem doenças    
rota.route("/training/days")
    .all(Autenticar)
    .post(Register_Dias_Treino.saveDays);


//cadastrar usuario com doenças
rota.route("/training/days/doencas")
    .all(Autenticar)
    .get(Register_Dias_Treino_Doencas.getDisease)
    .post(Register_Dias_Treino_Doencas.saveDaysDoenca);

rota.route("/training/:weekday").get(Autenticar, Training.getTraining);
rota.route("/training/vip/:weekday").get(Autenticar, Training.getTrainingVip);

rota.route("/planImprovements").post(Autenticar, Plan_Improvements.saveInprovements);


export default rota;