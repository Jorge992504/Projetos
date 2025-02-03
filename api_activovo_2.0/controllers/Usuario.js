import database from "../database/database.js";
import bcrypt from "bcrypt";

async function getUser(req, res) {
    try {
        const id = req.id;
        
        let user = (await database.query("SELECT * FROM users where id = $1;", [req.id]));
        res.send(user.rows[0]);
    } catch (error) {
        console.error('Erro ao buscar usuário ','erro: ', error);
    }
}

async function saveUsers(req, res) {
    try {
        const { name, password, email, profile } = req.body;
        let user = await database.query("SELECT * FROM users where email = $1", [email]);
        if (user.rows.length) {
            return res.status(400).send({ error: "Usuário já cadastrado" });
        } else {
            const passwordNew = await bcrypt.hash(password, 10);
            await database.query("Insert into users (name, password, email, profile) values ($1,$2,$3,$4) RETURNING id,password;", [name, passwordNew, email,profile]);
            return res.status(200).send("Usuário cadastrado com sucesso");
        }
    } catch (error) {
        console.error('Erro ao cadastrar usuário ', 'erro: ', error);
    }

}

async function modifyUser(req, res) {
    try {
        const { profile } = req.body;
        const id = req.id;

        // Atualiza o perfil do usuário
        await database.query("UPDATE users SET profile = $1 WHERE id = $2", [profile, id]);

        if (profile === "VIP") {
            // Lê os dias da tabela 'training' para o usuário
            const resultTraining = await database.query(
                "SELECT DISTINCT days FROM training WHERE user_id = $1",
                [id]
            );

            // Verifica se há dias associados
            if (resultTraining.rows.length === 0) {
                return res.status(404).send("Nenhum dia encontrado para o usuário na tabela 'training'.");
            }

            const days = resultTraining.rows.map(row => row.days);

            // Obtém 4 exercícios aleatórios da tabela 'exercise_vip' apenas uma vez
            const resultExercises = await database.query(
                "SELECT id FROM exercise_vip ORDER BY RANDOM() LIMIT 4"
            );

            // Verifica se existem exercícios suficientes
            if (resultExercises.rows.length < 4) {
                return res.status(404).send("Não há exercícios VIP suficientes para atribuir.");
            }

            const exerciseIds = resultExercises.rows.map(row => row.id);

            // Insere 4 exercícios para cada dia na tabela 'training_vip'
            for (const day of days) {
                await Promise.all(
                    exerciseIds.map(async (exerciseId) => {
                        await database.query(
                            "INSERT INTO training_vip (user_id, exercise_id, days) VALUES ($1, $2, $3)",
                            [id, exerciseId, day]
                        );
                    })
                );
            }
        }

        res.status(200).send("Usuário alterado e treinos VIP atualizados com sucesso!");
    } catch (error) {
        console.error("Erro ao alterar as informações do usuário e atualizar os treinos VIP", "erro: ", error);
        res.status(500).send("Erro ao alterar o usuário ou atualizar treinos VIP.");
    }
}




async function getUsers(req, res) {
    try {
        const id = req.id;
        let user = (await database.query("SELECT * FROM users;"));
        
        res.send(user.rows);
    } catch (error) {
        console.error('Erro ao buscar usuário ','erro: ', error);
    }
}

export default { getUser, saveUsers, modifyUser,getUsers };




 
 
 
 

 