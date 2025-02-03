select * from training;
select * from users;
select * from exercise;
select * from plan_improvements;

CREATE TABLE plan_improvements (
    id SERIAL PRIMARY KEY,         
    user_id INTEGER NOT NULL,      
    improvement VARCHAR(255) NOT NULL      
);

CREATE TABLE training_vip (
    id SERIAL PRIMARY KEY,         
    user_id INTEGER NOT NULL,      
    days VARCHAR(255) NOT NULL,    
	exercise_id integer not null 
);

CREATE TABLE exercise_vip (
    id SERIAL PRIMARY KEY,         
    name VARCHAR(255) NOT NULL,      
    description VARCHAR(255),
	series integer, 
	repetitions integer,
	video VARCHAR(255)
);


insert into exercise_vip (name, description, series, repetitions, video) values ('1-EXERCISE-VIP','DESCRIPTIO DO EXERCISE VIP',4,10,'teste.mp4');
insert into exercise_vip (name, description, series, repetitions, video) values ('2-EXERCISE-VIP','DESCRIPTIO DO EXERCISE VIP',4,10,'teste.mp4');
insert into exercise_vip (name, description, series, repetitions, video) values ('3-EXERCISE-VIP','DESCRIPTIO DO EXERCISE VIP',4,10,'teste.mp4');
insert into exercise_vip (name, description, series, repetitions, video) values ('4-EXERCISE-VIP','DESCRIPTIO DO EXERCISE VIP',4,10,'teste.mp4');

insert into exercise_vip (name, description, series, repetitions, video) values ('5-EXERCISE-VIP','DESCRIPTIO DO EXERCISE VIP',4,10,'teste.mp4');
insert into exercise_vip (name, description, series, repetitions, video) values ('6-EXERCISE-VIP','DESCRIPTIO DO EXERCISE VIP',4,10,'teste.mp4');
insert into exercise_vip (name, description, series, repetitions, video) values ('7-EXERCISE-VIP','DESCRIPTIO DO EXERCISE VIP',4,10,'teste.mp4');
insert into exercise_vip (name, description, series, repetitions, video) values ('8-EXERCISE-VIP','DESCRIPTIO DO EXERCISE VIP',4,10,'teste.mp4');

insert into exercise_vip (name, description, series, repetitions, video) values ('9-EXERCISE-VIP','DESCRIPTIO DO EXERCISE VIP',4,10,'teste.mp4');
insert into exercise_vip (name, description, series, repetitions, video) values ('10-EXERCISE-VIP','DESCRIPTIO DO EXERCISE VIP',4,10,'teste.mp4');
insert into exercise_vip (name, description, series, repetitions, video) values ('11-EXERCISE-VIP','DESCRIPTIO DO EXERCISE VIP',4,10,'teste.mp4');
insert into exercise_vip (name, description, series, repetitions, video) values ('12-EXERCISE-VIP','DESCRIPTIO DO EXERCISE VIP',4,10,'teste.mp4');

insert into exercise_vip (name, description, series, repetitions, video) values ('13-EXERCISE-VIP','DESCRIPTIO DO EXERCISE VIP',4,10,'teste.mp4');
insert into exercise_vip (name, description, series, repetitions, video) values ('14-EXERCISE-VIP','DESCRIPTIO DO EXERCISE VIP',4,10,'teste.mp4');
insert into exercise_vip (name, description, series, repetitions, video) values ('15-EXERCISE-VIP','DESCRIPTIO DO EXERCISE VIP',4,10,'teste.mp4');
insert into exercise_vip (name, description, series, repetitions, video) values ('16-EXERCISE-VIP','DESCRIPTIO DO EXERCISE VIP',4,10,'teste.mp4');

insert into exercise_vip (name, description, series, repetitions, video) values ('17-EXERCISE-VIP','DESCRIPTIO DO EXERCISE VIP',4,10,'teste.mp4');
insert into exercise_vip (name, description, series, repetitions, video) values ('18-EXERCISE-VIP','DESCRIPTIO DO EXERCISE VIP',4,10,'teste.mp4');
insert into exercise_vip (name, description, series, repetitions, video) values ('19-EXERCISE-VIP','DESCRIPTIO DO EXERCISE VIP',4,10,'teste.mp4');
insert into exercise_vip (name, description, series, repetitions, video) values ('20-EXERCISE-VIP','DESCRIPTIO DO EXERCISE VIP',4,10,'teste.mp4');
