import { request, response } from "express";

import Jwt from "jsonwebtoken";

/**
 * 
 * @param {request} req 
 * @param {response} res 
 * @param {function} next 
 */
async function Autenticar(req, res, next) {
    let { authorization } = req.headers;
    authorization = authorization.replace("Bearer ", "");
    
    Jwt.verify(authorization, process.env.SECRET_KEY, (err, decoded) => {
        if (err) {
            return res.status(403).send({ error: "Token invalido" })
        }
        req.id = decoded.id;
        req.user = decoded.user;
        req.email = decoded.email;
        next();
    });
}

export default Autenticar;
