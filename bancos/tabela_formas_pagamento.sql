CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    nome VARCHAR(255) NOT NULL,
    senha VARCHAR(255) NOT NULL,
    foto VARCHAR(255)
);


select * from usuarios;
select * from formas_pagamentos;


CREATE TABLE formas_pagamentos (
    id SERIAL PRIMARY KEY,     
    nome VARCHAR(255) UNIQUE,  
    acronym VARCHAR(10),       
    enabled BOOLEAN DEFAULT true 
);

INSERT INTO formas_pagamentos (nome, acronym, enabled) 
VALUES 
('Pix', 'PX', true),
('Boleto', 'BT', true),
('Cartão Credito', 'CC', true),
('Cartão Debito', 'CD', true);

