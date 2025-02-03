-- Tabela Users
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    profile VARCHAR(255),
    work_days VARCHAR(255), 
    work_hours INT          
);

-- Tabela Barber Shop
CREATE TABLE barber_shop (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    opening_days VARCHAR(255), 
    opening_hours INT,         
    CONSTRAINT fk_user
        FOREIGN KEY (user_id) REFERENCES users(id) -- Chave estrangeira referenciando a tabela users
);

-- Tabela Horarios
CREATE TABLE horarios (
    id SERIAL PRIMARY KEY,
    barbershop_id INT NOT NULL,
    user_id INT NOT NULL,
    client_name VARCHAR(255) NOT NULL,
    data DATE NOT NULL,     -- Data do horário
    time TIME NOT NULL,     -- Hora do horário
    CONSTRAINT fk_barbershop
        FOREIGN KEY (barbershop_id) REFERENCES barber_shop(id), -- Chave estrangeira referenciando a tabela barber_shop
    CONSTRAINT fk_user_horarios
        FOREIGN KEY (user_id) REFERENCES users(id) -- Chave estrangeira referenciando a tabela users
);
