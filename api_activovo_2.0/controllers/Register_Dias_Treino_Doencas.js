import database from "../database/database.js";


async function saveDaysDoenca(req, res) {
  try {
    const { days, disease_id: diseases } = req.body; // Extração correta
    const id = req.id;

    // Validações dos dados recebidos
    if (!days || !Array.isArray(days) || days.length === 0) {
      return res.status(400).send("A lista de dias não pode estar vazia ou inválida.");
    }

    if (!diseases || !Array.isArray(diseases) || diseases.length === 0) {
      return res.status(400).send("A lista de doenças não pode estar vazia ou inválida.");
    }

    if (!id) {
      return res.status(400).send("O ID do usuário é obrigatório.");
    }

    // Salvar doenças na tabela user_disease
    const diseasePromises = diseases.map((diseaseId) =>
      database.query(
        "INSERT INTO user_disease (user_id, disease_id) VALUES ($1, $2) ON CONFLICT DO NOTHING",
        [id, diseaseId]
      )
    );
    await Promise.all(diseasePromises); // Processar em paralelo

    // Obter exercícios correspondentes às doenças
    const resultDiseaseExercises = await database.query(
      "SELECT DISTINCT exercise_id FROM disease_exercise WHERE disease_id = ANY($1)",
      [diseases]
    );

    if (resultDiseaseExercises.rows.length === 0) {
      return res.status(404).send("Nenhum exercício correspondente encontrado.");
    }

    const exerciseIds = resultDiseaseExercises.rows.map((row) => row.exercise_id);

    // Iterar sobre os dias e inserir treinos
    const trainingPromises = days.map((day) => {
      // Selecionar 4 exercícios aleatórios
      const selectedExercises = exerciseIds
        .sort(() => Math.random() - 0.5) // Embaralhar a lista
        .slice(0, 4); // Selecionar os 4 primeiros

      // Inserir os treinos para os exercícios selecionados
      return Promise.all(
        selectedExercises.map((exerciseId) =>
          database.query(
            "INSERT INTO training (user_id, exercise_id, days) VALUES ($1, $2, $3)",
            [id, exerciseId, day]
          )
        )
      );
    });
    await Promise.all(trainingPromises); // Processar em paralelo

    res.status(200).send("Dias e doenças cadastrados com sucesso!");
  } catch (error) {
    console.error("Erro ao salvar os dias de treinamento:", error);
    res.status(500).send("Erro ao salvar os dias de treinamento.");
  }
}

  


async function getDisease(req, res) {
    try {
        let disease = (await database.query("SELECT id, name FROM disease;"));
        
        res.send(disease.rows);
    } catch (error) {
        console.error('Erro ao buscar doenca ','erro: ', error);
    }
}


export default { saveDaysDoenca, getDisease };