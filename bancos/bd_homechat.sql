select * from Users;

insert into Users (name, email, password) values ('Teste1', 'teste1@gmail.com', '$2b$10$uTstx2ARYXKIvYHcYymPue3PMdihwm1AwX11MOLuMY6zTK4rhEQLe');
insert into Users (name, email, password) values ('Teste2', 'teste2@gmail.com', '$2b$10$uTstx2ARYXKIvYHcYymPue3PMdihwm1AwX11MOLuMY6zTK4rhEQLe');
insert into Users (name, email, password) values ('Teste3', 'teste3@gmail.com', '$2b$10$uTstx2ARYXKIvYHcYymPue3PMdihwm1AwX11MOLuMY6zTK4rhEQLe');
insert into Users (name, email, password) values ('Teste4', 'teste4@gmail.com', '$2b$10$uTstx2ARYXKIvYHcYymPue3PMdihwm1AwX11MOLuMY6zTK4rhEQLe');
insert into Users (name, email, password) values ('Teste5', 'teste5@gmail.com', '$2b$10$uTstx2ARYXKIvYHcYymPue3PMdihwm1AwX11MOLuMY6zTK4rhEQLe');


-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/csGicI
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE Users (
    "id" serial,
    "name" varchar NOT NULL,
    "email" varchar   NOT NULL  unique,
    "password" varchar   NOT NULL,
    "confirmation" bool not null,
	"code" int not null,
    CONSTRAINT "pk_Users" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE SendEmail (
    "id" serial,
    "email" varchar unique   NOT NULL,
    "text" text   ,
    "status" varchar   NOT NULL,
    "code" int   ,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP,
    CONSTRAINT "pk_SendEmail" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE Messages (
    "id" serial,
    "sender_id" int   NOT NULL,
    "receiver_id" int   NOT NULL,
    "text" text   NOT NULL,
    "created_at" timestamp   NOT NULL,
    "status" varchar   NOT NULL,
    CONSTRAINT "pk_Messages" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE friends (
    id SERIAL PRIMARY KEY,              
    
    user_id INT NOT NULL,               
    friend_id INT NOT NULL,             
    request BOOLEAN DEFAULT TRUE,       
    created_at TIMESTAMP DEFAULT NOW(), 
    updated_at TIMESTAMP DEFAULT NOW(), 

    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_friend FOREIGN KEY (friend_id) REFERENCES users(id) ON DELETE CASCADE
);


select * from sendemail;


