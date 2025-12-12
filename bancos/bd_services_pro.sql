CREATE TABLE servico (
    id SERIAL PRIMARY KEY ,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT
);
insert into servico ("nome","descricao") values ('Serviços Domésticos','Inclui serviços tals como: Faxineira / Diarista, Passadeira, Cozinheira, Babá, Cuidador de Idosos, Personal Organizer, Lavanderia Delivery, Jardineiro, Piscineiro, Zelador Residencial.');
insert into servico ("nome","descricao") values ('Reparos e Manutenção','Inclui serviços tals como: Eletricista, Encanador, Pintor, Pedreiro, Gesseiro, Azulejista, Marceneiro, Serralheiro, Técnico de Portão Eletrônico, Técnico de Ar-condicionado, Técnico Hidráulico, Técnico em Refrigeração, Calheiro / Soldador, Montador de Móveis, Desentupidor.');
insert into servico ("nome","descricao") values ('Mudança, Transporte e Entregas','Inclui serviços tals como: Freteiro, Carreteiro, Motoboy, Transportador de Encomendas, Montador de Móveis, Desmontagem e Mudança, Carregador / Ajudante.');
insert into servico ("nome","descricao") values ('Beleza e Estética','Inclui serviços tals como: Cabeleireiro, Maquiador(a), Manicure / Pedicure, Designer de Sobrancelhas, Depiladora, Lash Designer, Massoterapeuta, Esteticista Facial, Barbeiro.');
insert into servico ("nome","descricao") values ('Tecnologia','Inclui serviços tals como: Técnico de Informática, Instalação de Wi-Fi / Rede, Formatação / Limpeza de PC, Suporte Técnico Doméstico, Instalação de Câmeras (CFTV), Instalação de Smart Home.');
insert into servico ("nome","descricao") values ('Área Pet','Inclui serviços tals como: Veterinário a domicílio, Tosador, Dog Walker / Passeador, Petsitter (babá de pet), Adestrador, Pet Taxi, Banho & Tosa Móvel.');
insert into servico ("nome","descricao") values ('Fitness e Bem-estar','Inclui serviços tals como: Personal Trainer, Nutricionista, Fisioterapeuta, Instrutor de Yoga, Instrutor de Pilates, Quiropraxista, Massoterapeuta.');
insert into servico ("nome","descricao") values ('Consultoria e Profissionais Especializados','Inclui serviços tals como: Contador, Advogado Consultor, Coach / Mentor, Consultor de Finanças, Consultor de Marketing, Consultor Imobiliário.');
insert into servico ("nome","descricao") values ('Eventos','Inclui serviços tals como: Fotógrafo, Videomaker, Decorador, DJ, Garçom, Barman, Cozinheiro para eventos, Buffet, Sonorização / Iluminação.');
insert into servico ("nome","descricao") values ('Automotivo','Inclui serviços tals como: Mecânico Móvel, Chaveiro Automotivo, Lavagem a Seco / Detalhamento, Funileiro, Guincho / Reboque.');
insert into servico ("nome","descricao") values ('Reforma e Construção','Inclui serviços tals como: Mestre de Obras, Engenheiro Civil, Arquiteto, Topógrafo, Técnico em Segurança do Trabalho.');
insert into servico ("nome","descricao") values ('Segurança','Inclui serviços tals como: Chaveiro, Instalador de Fechaduras Digitais, Segurança Particular, Vigia.');
insert into servico ("nome","descricao") values ('Serviços Administrativos','Inclui serviços tals como: Assistente Administrativo Freelance, Serviços de Digitação, Serviços de Contabilidade Básica, Emissão de Notas / Consultoria MEI.');

select * from servico;