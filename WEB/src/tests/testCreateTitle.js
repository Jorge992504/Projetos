import fetch from 'node-fetch';

const title = {
  clientId: 1,
  value: 1545,
  dueDate: '2025-16-05'
};

fetch('http://localhost:3000/titles', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify(title)
})
  .then((res) => res.json())
  .then((data) => {
    console.log('Título criado:', data);
  })
  .catch((err) => {
    console.error('Erro ao criar título:', err);
  });
