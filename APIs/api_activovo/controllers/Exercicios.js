import database from "../database/database.js";
async function listarExercicios(req, res) {
    
    let exercicios = (await database.query("SELECT * FROM exercicio")).rows;
    
    // exercicios = exercicios.map(exercicio => {
    //     if(exercicio.video){
    //         exercicio.video = "http://localhost:3000/public/video/" + exercicio.video;
    //     }else{
    //         exercicio.video = "http://localhost:3000/public/video/teste.mp4";
    //     }
    //     return exercicio;
    // });
    exercicios = exercicios.map(exercicio => {
        if(exercicio.video){
            exercicio.video = "http://192.168.3.20:3000/public/videos/" + exercicio.video;
        }else{
            exercicio.video = "http://192.168.3.20:3000/public/videos/teste.mp4";
        }
        return exercicio;
    });
    
     
    res.send(exercicios);
}
async function deletarExercicio(req, res) {
    const { id } = req.params;
    await database.query("delete from exercicio where id = $1;", [id]);
    return res.send("Exercicio deletado");
}

export default {listarExercicios,deletarExercicio};



// export default {listarExercicios};
// export default {
//     listarExercicios: async (req, res) => {
//         exercicio = (await database.query("SELECT * FROM exercicio"));
//         res.send(exercicio);
//     }
// }

// const listarExercicios = async (req, res) => {
//     try {
//       const result = await pool.query('SELECT * FROM exercicios');
//       res.status(200).json(result.rows);
//     } catch (error) {
//       console.error('Erro ao buscar exercícios:', error);
//       res.status(500).json({ message: error.message });
//     }
//   };