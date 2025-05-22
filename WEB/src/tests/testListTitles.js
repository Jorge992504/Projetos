import fetch from 'node-fetch';

fetch('http://localhost:3000/titles')
  .then((res) => res.json())
  .then((data) => {
    console.log('Lista de títulos:', data);
  })
  .catch((err) => {
    console.error('Erro ao listar títulos:', err);
  });
