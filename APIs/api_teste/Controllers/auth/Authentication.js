import { request, response } from "express";
import Jwt from "jsonwebtoken";


/**
 * @param {request} req
 * @param {response} res
 * @param {function} next
 */

async function Authentication(req, res, next) {
    let {authorization} = req.headers;
    authorization = authorization.replace("Bearer ", "");

    Jwt.verify(authorization, process.env.SECRET_KEY, (err, decoded) => {
        if (err) {
            return res.status(403).send({error: "Token inválido"})
        }
        req.id = decoded.id;
        req.email = decoded.email;
        next();
    });
}

export default Authentication;