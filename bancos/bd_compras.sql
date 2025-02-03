CREATE TABLE Users (
    id SERIAL PRIMARY KEY,       -- ID único e auto-incrementado
    name VARCHAR(100) NOT NULL,  -- Nome do usuário
    email VARCHAR(255) NOT NULL, -- Email do usuário
    password VARCHAR(255) NOT NULL -- Senha do usuário
);

CREATE TABLE Products (
    id SERIAL PRIMARY KEY,        -- ID único e auto-incrementado
    name VARCHAR(100) NOT NULL,   -- Nome do produto
    foto TEXT                     -- URL ou descrição da foto
);

CREATE TABLE Select_Products (
    id SERIAL PRIMARY KEY,        -- ID único e auto-incrementado
    user_id INT NOT NULL,         -- Referência ao usuário
    product_id INT NOT NULL,      -- Referência ao produto
    FOREIGN KEY (user_id) REFERENCES USERS (id) ON DELETE CASCADE,    -- Relacionamento com USERS
    FOREIGN KEY (product_id) REFERENCES Products (id) ON DELETE CASCADE -- Relacionamento com Products
);

insert into users (name, email, password) values ('comprasTeste', 'comprasTeste@gmail.com', '$2y$10$QXZUqV4k3QY1CbenIpIobOaGv1zJ1CMnhiV5B0TVaiFLpgPmGB3W.');
select * from users;

INSERT INTO products (name, foto) VALUES
('Arroz', 'arroz.png'),
('Feijão', 'feijao.png'),
('Macarrão', 'macarrao.png'),
('Óleo de cozinha', 'oleo_de_cozinha.png'),
('Açúcar', 'acucar.png'),
('Sal', 'sal.png'),
('Café', 'cafe.png'),
('Leite', 'leite.png'),
('Pão', 'pao.png'),
('Frutas', 'frutas.png'),
('Verduras e legumes', 'verduras_e_legumes.png'),
('Carnes', 'carnes.png'),
('Laticínios', 'laticinios.png'),
('Sucos e bebidas', 'sucos_e_bebidas.png'),
('Detergente líquido', 'detergente_liquido.png'),
('Sabão em pó', 'sabao_em_po.png'),
('Desinfetante', 'desinfetante.png'),
('Amaciante de roupas', 'amaciante_de_roupas.png'),
('Limpa vidros', 'limpa_vidros.png'),
('Pano de chão', 'pano_de_chao.png'),
('Esponja de limpeza', 'esponja_de_limpeza.png'),
('Desodorante para ambientes', 'desodorante_para_ambientes.png'),
('Papel toalha', 'papel_toalha.png'),
('Sacos de lixo', 'sacos_de_lixo.png'),
('Desinfetante de banheiro', 'desinfetante_de_banheiro.png'),
('Sabonete', 'sabonete.png'),
('Shampoo e condicionador', 'shampoo_e_condicionador.png'),
('Creme dental', 'creme_dental.png'),
('Papel higiênico', 'papel_higienico.png'),
('Desodorante', 'desodorante.png'),
('Toalhas', 'toalhas.png'),
('Lâminas de barbear', 'laminas_de_barbear.png'),
('Absorventes femininos', 'absorventes_femininos.png'),
('Panela', 'panela.png'),
('Frigideira', 'frigideira.png'),
('Talheres', 'talheres.png'),
('Pratos e copos', 'pratos_e_copos.png'),
('Taças e xícaras', 'tacas_e_xicaras.png'),
('Tupperware', 'tupperware.png'),
('Faca de cozinha', 'faca_de_cozinha.png'),
('Ralador', 'ralador.png'),
('Tábua de corte', 'tabua_de_corte.png'),
('Toalhas de banho', 'toalhas_de_banho.png'),
('Tapete de banheiro', 'tapete_de_banheiro.png'),
('Cortina de banheiro', 'cortina_de_banheiro.png'),
('Cesto de lixo', 'cesto_de_lixo.png'),
('Escova de vaso sanitário', 'escova_de_vaso_sanitario.png'),
('Lâmpadas', 'lampadas.png'),
('Pilhas e baterias', 'pilhas_e_baterias.png'),
('Extensão elétrica', 'extensao_eletrica.png'),
('Fios e cabos', 'fios_e_cabos.png'),
('Produtos de manutenção', 'produtos_de_manutencao.png'),
('Velas', 'velas.png'),
('Caixas organizadoras', 'caixas_organizadoras.png'),
('Cestos', 'cestos.png'),
('Cabides', 'cabides.png'),
('Organizadores de gaveta', 'organizadores_de_gaveta.png'),
('Prateleiras e suportes', 'prateleiras_e_suportes.png'),
('Travesseiros', 'travesseiros.png'),
('Lençóis e fronhas', 'lencois_e_fronhas.png'),
('Cobertores', 'cobertores.png'),
('Colchões', 'colchoes.png'),
('Cortinas', 'cortinas.png'),
('Filmes e livros', 'filmes_e_livros.png'),
('Jogos de tabuleiro', 'jogos_de_tabuleiro.png'),
('Aparelhos eletrônicos', 'aparelhos_eletronicos.png');














