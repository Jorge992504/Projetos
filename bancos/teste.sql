CREATE TABLE teste (
    id SERIAL PRIMARY KEY,      -- Incrementa automaticamente o ID
    name VARCHAR(100) NOT NULL, -- Nome com até 100 caracteres
    descricao TEXT,             -- Descrição mais longa
    quantidade INT              -- Quantidade
);



INSERT INTO teste (name, descricao, quantidade) VALUES
('A Produto-a', 'Descrição do Produto A', 10),
('B Produto', 'Descrição do Produto B', 15),
('C Produto', 'Descrição do Produto C', 20),
('A Produto-a', 'Descrição do Produto D', 25),
('E Produto', 'Descrição do Produto E', 30),
('B Produto-b', 'Descrição do Produto F', 35),
('G Produto', 'Descrição do Produto G', 40),
('B Produto-b', 'Descrição do Produto H', 45),
('A Produto-a', 'Descrição do Produto I', 50),
('J Produto', 'Descrição do Produto J', 55);





select id from teste where name like 'A%';
