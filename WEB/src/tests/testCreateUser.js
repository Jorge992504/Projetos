import fetch from 'node-fetch';

const user = {
  name: 'Juan Sarmiento',
  email: 'jasr4075@unochapeco.edu.br'
};

fetch('http://localhost:3000/users', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify(user)
})
  .then((res) => res.json())
  .then((data) => {
    console.log('Usuário criado:', data);
  })
  .catch((err) => {
    console.error('Erro ao criar usuário:', err);
  });