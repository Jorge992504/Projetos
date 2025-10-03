insert into produtos (descricao, descricao_qtde, disponivel, image, nome, quantidade, categoria_id) values 
('Lanche acompanha pão, hambúguer, mussarela, alface, tomate e maionese','g',true,'xSalada.png','X-Salada',150,1);

insert into produtos (descricao, descricao_qtde, disponivel, image, nome, quantidade, categoria_id) values 
('Lanche acompanha pão, hambúguer, mussarela e maionese','g',true,'xBurguer.png','X-Burger',170,2);
insert into produtos (descricao, descricao_qtde, disponivel, image, nome, quantidade, categoria_id) values 
('Lanche acompanha pão, hambúguer, mussarela e maionese','g',true,'xBurguer.png','X-Burger',170,6);

insert into produtos (descricao, descricao_qtde, disponivel, image, nome, quantidade, categoria_id) values 
('Lanche acompanha pão francês, contra filé, alface, vinagrete, queijo e maionese','g',true,'xChurrasco.png','X-Churrasco',200,3);

insert into produtos (descricao, descricao_qtde, disponivel, image, nome, quantidade, categoria_id) values 
('Coca-Cola','l',true,'coca.png','Coca',1.5,5);

insert into produtos (descricao, descricao_qtde, disponivel, image, nome, quantidade, categoria_id) values 
('Salmão cru, com arroz','g',true,'sushi.png','Sushi',270,4);


insert into categorias (categoria) values ('Veganos');
insert into categorias (categoria) values ('Carnes');
insert into categorias (categoria) values ('Pizzas');
insert into categorias (categoria) values ('Sushi');
insert into categorias (categoria) values ('Refrigerantes');
insert into categorias (categoria) values ('Hambugues');

select * from categorias;
select * from produtos;

SELECT p.id,
       p.nome AS produto,
       c.categoria AS categoria
FROM produtos p
JOIN categorias c ON p.categoria_id = c.id
WHERE c.id = 1;


insert into variacoes (descricao_qtde, preco, quantidade, produto_id) values ('UN', 15.0, 1, 1);
insert into variacoes (descricao_qtde, preco, quantidade, produto_id) values ('UN', 25.0, 1, 2);
insert into variacoes (descricao_qtde, preco, quantidade, produto_id) values ('UN', 25.0, 1, 3);

insert into variacoes (descricao_qtde, preco, quantidade, produto_id) values ('UN', 47.99,1, 4);
insert into variacoes (descricao_qtde, preco, quantidade, produto_id) values ('UN', 12.0,1, 5);
insert into variacoes (descricao_qtde, preco, quantidade, produto_id) values ('UN', 145.0, 1, 6);

select * from variacoes;
select * from variacoes v join produtos p on v.produto_id = p.id where p.id = 1;
