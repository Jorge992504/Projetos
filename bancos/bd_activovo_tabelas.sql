CREATE TABLE "user" (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    days VARCHAR(255),
    profile VARCHAR(255)
);

CREATE TABLE disease (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT
);

CREATE TABLE exercise (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255),
    series INT NOT NULL,
    repetitions INT NOT NULL
);

CREATE TABLE user_disease (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES "user" (id) ON DELETE CASCADE,
    disease_id INT NOT NULL REFERENCES disease (id) ON DELETE CASCADE,
    UNIQUE (user_id, disease_id)
);

CREATE TABLE disease_exercise (
    id SERIAL PRIMARY KEY,
    disease_id INT NOT NULL REFERENCES disease (id) ON DELETE CASCADE,
    exercise_id INT NOT NULL REFERENCES exercise (id) ON DELETE CASCADE,
    UNIQUE (disease_id, exercise_id)
);

CREATE TABLE training (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES "user" (id) ON DELETE CASCADE,
    exercise_id INT NOT NULL REFERENCES exercise (id) ON DELETE CASCADE,
    days VARCHAR(255)
);

insert into user (name, password, email, profile) values ('teste', '1234','teste','user');

CREATE TABLE plan_improvements (
    id SERIAL PRIMARY KEY,         -- Campo ID com incremento automático
    user_id INTEGER NOT NULL,      -- Relaciona o ID do usuário
    improvement TEXT NOT NULL      -- Campo para descrever a melhoria
);
