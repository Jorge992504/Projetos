let users = [];
let userIdCounter = 1;

export const createUser = (req, res) => {
  const { name, email } = req.body;

  if (!name || !email) return res.status(400).json({ error: 'Nome e e-mail são obrigatórios.' });

  const newUser = { id: userIdCounter++, name, email };
  users.push(newUser);

  res.status(201).json(newUser);
};

export const getUsers = (req, res) => {
  res.json(users);
};

export const findUserById = (id) => {
  return users.find((user) => user.id === parseInt(id));
};
