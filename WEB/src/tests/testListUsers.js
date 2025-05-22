import fetch from 'node-fetch';

fetch('http://localhost:3000/users')
  .then((res) => res.json())
  .then((data) => {
    console.log('Lista de usuários:', data);
  })
  .catch((err) => {
    console.error('Erro ao listar usuários:', err);
  });
