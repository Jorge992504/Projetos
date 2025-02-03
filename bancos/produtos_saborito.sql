CREATE TABLE produtos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) UNIQUE NOT NULL,
    descricao TEXT,
    foto VARCHAR(255)
);

INSERT INTO produtos (nome, descricao, foto) VALUES
('Cheeseburger Clássico', 'Hambúrguer suculento com queijo cheddar derretido, alface, tomate, picles e molho especial, servido em um pão macio.', 'CheeseburgerClássico.png'),
('Chicken Wrap', 'Tiras de frango grelhado, alface, tomate e molho ranch, enrolados em uma tortilla macia.', 'ChickenWrap.png'),
('Misto Quente', 'Sanduíche quente com presunto, queijo e manteiga, prensado até ficar crocante e derretido.', 'MistoQuente.png'),
('Veggie Burger', 'Hambúrguer vegetariano feito com grão-de-bico, coberto com alface, tomate, cebola roxa e molho de iogurte.', 'VeggieBurger.png'),
('Cachorro-Quente Completo', 'Salsicha grelhada servida em um pão macio, coberta com molho de tomate, milho, ervilha, batata-palha e maionese.', 'Cachorro-QuenteCompleto.png'),
('Bauru', 'Sanduíche tradicional com rosbife, queijo derretido, tomate e pepino em conserva, servido em pão francês.', 'Bauru.png'),
('Frango Crispy', 'Filé de frango empanado e crocante, acompanhado de alface, maionese e picles em um pão de brioche.', 'FrangoCrispy.png'),
('Tostex de Queijo e Presunto', 'Sanduíche tostado de queijo e presunto, simples e delicioso.', 'TostexdeQueijoePresunto.png'),
('Bagel com Salmão Defumado', 'Bagel macio com cream cheese, salmão defumado, alcaparras e cebola roxa.', 'BagelcomSalmãoDefumado.png'),
('Panini de Frango e Pesto', 'Panini com frango grelhado, pesto, queijo derretido e tomate seco.', 'PaninideFrangoePesto.png');

select * from produtos;