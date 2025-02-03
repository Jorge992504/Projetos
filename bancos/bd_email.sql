CREATE TABLE email (
    id SERIAL PRIMARY KEY, 
    email VARCHAR(255) NOT NULL, 
    text TEXT NOT NULL, 
    status VARCHAR(50) DEFAULT 'pendente', 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP
);

insert into email (email, text, status) values ('jorgeabp99@gmail.com', 'Texto des teste direito do banco de dados', 'Pendente');
insert into email (email, text, status) values ('bravojorgeangel5@gmail.com', 'Texto des teste direito do banco de dados', 'Pendente');

select * from email;

UPDATE email
SET 
    status = 'enviado',
    updated_at = CURRENT_TIMESTAMP
WHERE id = 1;
