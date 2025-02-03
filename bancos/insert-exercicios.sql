--exercicios_doencas
select id, nome from exercicio;

insert into exercicio_doenca (id_doenca, id_exercicio, beneficio) values
(2,4,true),
(2,5,true),
(2,6,true),
(2,7,true),
(3,8,true),
(3,9,true),
(3,10,true),
(3,11,true),
(8,2,true),
(8,12,true),
(10,13,true),
(10,14,true),
(10,15,true),
(5,16,true),
(5,17,true),
(5,18,true),
(11,19,true),
(11,20,true),
(11,21,true),
(7,22,true),
(7,23,true),
(7,24,true);

select * from exercicio_doenca;
select id_exercicio from exercicio_doenca where id_doenca = 10;
