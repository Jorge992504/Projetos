import express, { request } from "express";
import "dotenv/config.js"
import rota from "./routes.js";


const app = express()
app.use(express.json())

app.use(rota);

app.listen(4000, () => {
	console.log("Server iniciado: http://localhost:4000")
})



