import express from 'express';
import userRoutes from './src/routes/userRoutes.js';
import titleRoutes from './src/routes/titleRoutes.js';

const app = express();
app.use(express.json());

app.use('/users', userRoutes);
app.use('/titles', titleRoutes);

app.get('/', (req, res) => {
  const name = process.env.NAME || 'World';
  res.send(`Hello ${name}!`);
});

const port = parseInt(process.env.PORT) || 3000;
app.listen(port, () => {
  console.log(`http://localhost:${port}`);
});
