import * as express from "express";


import Authentication from "../Controllers/auth/Authentication.js";
import Login from "../Controllers/auth/Login.js";

import Users from '../Controllers/users/Users.js';
import Products from "../Controllers/products/products.js";
import Select_Products from "../Controllers/select_products/Select_Products.js";

const router = express.Router()

router.get('/', (req, res) => {
    res.send('API esta online')
})

router.use("/public", express.static("./public"));

router.post('/login',Login)
         

router.route('/users')
      .post(Users.post)
      .all(Authentication)
      .get(Users.get)

router.route('/products')
      .get(Products.get)
      
router.route('/select/products')
      .all(Authentication)
      .get(Select_Products.get)
      .post(Select_Products.post)
      .delete(Select_Products.delet)


router.route('/select/products/new')
      .all(Authentication)
      .post(Select_Products.postNewProduct)



export default router;