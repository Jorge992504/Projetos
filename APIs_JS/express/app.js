import express ,{request} from "express";
import routers from "./routes/routes.js";
const app = express()



app.use(express.json())
app.use(routers)

app.listen(6666, ()=>{
    console.log('')
    console.log('|--------------------------------|')
    console.log('| Servidor rodando na porta 6666 |')
    console.log('|--------------------------------|')
    console.log('')
}) 