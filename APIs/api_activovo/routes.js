import * as express from "express";
import Usuario from "./controllers/Usuario.js";
import Login from "./auth/Login.js";
import Autenticar from "./auth/Autenticar.js";
// import usuario_doenca from "./controllers/usuario_doenca.js";
import Usuario_doenca from "./controllers/Usuario_doenca.js";
import Exercicio_doenca from "./controllers/Exercicio_doenca.js";

import Exercicios from "./controllers/Exercicios.js";
import Treino from "./controllers/Treino.js";
import doenca from "./controllers/doenca.js";
import Usuario_treino from "./controllers/Usuario_treino.js";
import Treino_semana from "./controllers/Treino_semana.js";
import Formas_pagamento from "./controllers/Formas_pagamento.js";


const rota = express.Router();

rota.use("/public", express.static("./public"));

rota.post("/login", Login);

//rotas cadastrar usuario
rota.route("/usuario")
    .post(Usuario.cadastrarUsuarios)
    // .all(Autenticar)
    .get(Usuario.listarUsuarios)
    .put(Usuario.alterarUsuario);

//rotas para relacionar os usuarios com as doencas
rota.route("/usuario/doenca")
    .all(Autenticar)
    .post(Usuario_doenca.relacionarDoenca)

//deletar doencas
rota.delete("/usuario/doenca/:id", Autenticar, Usuario_doenca.deletarDoenca);

//relacionar exercicios com doencas
rota.route("/exercicio/doenca")
    .all(Autenticar)
    .post(Exercicio_doenca.relacionarExercicios)
rota.delete("/exercicio/doenca/:id", Autenticar, Exercicio_doenca.deletarExercicio);

//relacionar usuarios com o treino
rota.route("/usuario/treino_semana")//--------------------------------------------------------------------------------------------
    .all(Autenticar)
    .get(Treino_semana.listarTreinoSemana)
    .put(Treino_semana.alterarTreino)
    .post(Treino_semana.CriarTreino)

rota.delete("/usuario/treino/:id_treino", Autenticar, Treino_semana.deletartreino);

//buscar exercicios
rota.route("/exercicio")
    .get(Exercicios.listarExercicios);

rota.route("/exercicio/:id").delete(Autenticar, Exercicios.deletarExercicio);

rota.route("/treino")
    .get(Treino.listarTreino)
    
    .delete(Treino.deletarTreino)

rota.route("/doenca")
    .get(doenca.listarDoencas)

rota.route("/usuario/treino")
    .all(Autenticar)
    .post(Usuario_treino.relacionarUsuarioTreino)
    .get(Usuario_treino.listarTreinoUsuario)
rota.route("/usuario/treino/:diaSemana").get( Autenticar,Usuario_treino.listarTreinoDia)

rota.route("/formas_pagamento")
    .get(Formas_pagamento.listarFormasPagamentos)




export default rota;