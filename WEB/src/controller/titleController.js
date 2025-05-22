import { findUserById } from './userController.js';

let titles = [];
let titleIdCounter = 1;

export const createTitle = (req, res) => {
  const { clientId, value, dueDate } = req.body;

  const client = findUserById(clientId);
  if (!client) return res.status(404).json({ error: 'Cliente não encontrado.' });

  if (!value || !dueDate) {
    return res.status(400).json({ error: 'Valor e data de vencimento são obrigatórios.' });
  }

  const newTitle = { id: titleIdCounter++, clientId, value, dueDate };
  titles.push(newTitle);

  res.status(201).json(newTitle);
};

export const getTitles = (req, res) => {
  res.json(titles);
};

export const getTitlesByClient = (req, res) => {
  const clientId = parseInt(req.params.clientId);
  const clientTitles = titles.filter((title) => title.clientId === clientId);

  res.json(clientTitles);
};
