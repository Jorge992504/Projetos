import * as express from "express";


import Authentication from "../Controllers/auth/Authentication.js";
import Login from "../Controllers/auth/Login.js";

import Users from '../Controllers/users/Users.js';
import Email from '../emails/email.js';
// import Products from "./Controllers/product";

import Messages from "../Controllers/messages/messages.js";

const router = express.Router()

router.get('/', (req, res) => {
    res.send('API esta online')
})

// rota.use("/public", express.static("./public"));

router.post('/login',Login)
         

router.route('/users')
      .post(Users.post)
      .all(Authentication)
      .get(Users.get)

router.route('/user')
      .all(Authentication)
      .get(Users.getUsers)

router.route('/confirm')
      .all(Authentication)
      .post(Users.confirmationCode)

router.route('/request')
      .all(Authentication)
      .post(Users.addRequest)
      .get(Users.getRequest)
      .patch(Users.aceptRequest)
      .delete(Users.deletRequest)
 
router.route('/friends')
      .all(Authentication)
      .get(Users.getFriends)
      .delete(Users.deletFriends)      
      
router.route('/email')
      .post(Email.saveEmail)

      
router.route('/messages')
      .all(Authentication) // Garante que o usuário esteja autenticado
      .post(Messages.sendMessage) // Enviar uma mensagem
      .get(Messages.getMessages); // Buscar mensagens entre dois usuários
      


export default router;