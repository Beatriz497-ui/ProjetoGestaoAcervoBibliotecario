create database livro_db_v2;
use livro_db_v2;

create table Usuarios
(
id_usuario INT primary key auto_increment,
nome varchar(100) NOT NULL,
sobrenome varchar(100) NOT NULL,
email varchar(150) NOT NULL UNIQUE,
senha varchar(255) NOT NULL
);

INSERT INTO Usuarios (nome, sobrenome, email, senha) VALUES
('Ana', 'Silva', 'ana.silva@email.com', 'senha123'),
('Bruno', 'Oliveira', 'bruno.o@email.com', 'segredo456'),
('Carla', 'Santos', 'carla.santos@email.com', 'p@ssword'),
('Diego', 'Lima', 'diego.lima@email.com', 'diego99'),
('Elena', 'Costa', 'elena.c@email.com', 'elena123'),
('Fabio', 'Pereira', 'fabio.p@email.com', 'fabio77'),
('Gisele', 'Almeida', 'gisele.a@email.com', 'gigi2024'),
('Hugo', 'Ferreira', 'hugo.f@email.com', 'hugo_boss'),
('Isabela', 'Rocha', 'isabela.r@email.com', 'isa_123'),
('João', 'Mendes', 'joao.m@email.com', 'joao_m'),
('Karina', 'Nunes', 'karina.n@email.com', 'nunes_k'),
('Lucas', 'Souza', 'lucas.s@email.com', 'lucas_pass'),
('Marina', 'Viana', 'marina.v@email.com', 'mavi_88'),
('Nuno', 'Gomes', 'nuno.g@email.com', 'nuno_pass'),
('Olivia', 'Duarte', 'olivia.d@email.com', 'olivia_d');

-- Atividade Prática 1

create table Livros
(
id_livro INT primary key auto_increment,
titulo varchar(255) NOT NULL,
descricao varchar(255) NOT NULL,
autor varchar(100) NOT NULL
);

INSERT INTO Livros (titulo, descricao, autor) VALUES
('O Alquimista', 'Uma jornada de autodescoberta.', 'Paulo Coelho'),
('Dom Casmurro', 'A dúvida de Bentinho sobre Capitu.', 'Machado de Assis'),
('1984', 'Um futuro distópico sob vigilância.', 'George Orwell'),
('O Pequeno Príncipe', 'Lições sobre amor e amizade.', 'Antoine de Saint-Exupéry'),
('Harry Potter e a Pedra Filosofal', 'O início da saga do bruxo.', 'J.K. Rowling'),
('O Senhor dos Anéis', 'A jornada para destruir o Um Anel.', 'J.R.R. Tolkien'),
('A Menina que Roubava Livros', 'A vida de Liesel durante a guerra.', 'Markus Zusak'),
('Cem Anos de Solidão', 'A história da família Buendía.', 'Gabriel García Márquez'),
('O Código Da Vinci', 'Um mistério envolvendo a Igreja.', 'Dan Brown'),
('Orgulho e Preconceito', 'A relação entre Elizabeth e Darcy.', 'Jane Austen'),
('Crime e Castigo', 'O dilema moral de Raskólnikov.', 'Fiódor Dostoiévski'),
('O Hobbit', 'As aventuras de Bilbo Bolseiro.', 'J.R.R. Tolkien'),
('Ensaio sobre a Cegueira', 'Uma epidemia de cegueira branca.', 'José Saramago'),
('A Revolução dos Bichos', 'Uma sátira política em uma fazenda.', 'George Orwell'),
('Memórias Póstumas de Brás Cubas', 'Um defunto narra sua vida.', 'Machado de Assis');

create table Estoque
(
id_estoque INT primary key auto_increment,
quantidade_atual INT NOT NULL DEFAULT 0,
id_livro INT NOT NULL,
CONSTRAINT fk_livro_estoque FOREIGN KEY (id_livro) REFERENCES Livros(id_livro) ON DELETE CASCADE
);

INSERT INTO Estoque (quantidade_atual, id_livro) VALUES
(50, 1), 
(30, 2), 
(15, 3), 
(100, 4), 
(25, 5),
(40, 6), 
(12, 7), 
(8, 8), 
(60, 9), 
(20, 10),
(50, 11), 
(30, 12), 
(15, 13), 
(100, 14), 
(25, 15);


create table Log_movimentacao_estoque
(
id_movimentacao INT primary key auto_increment,
data_movimentacao DATE NOT NULL,
tipo VARCHAR(100),
quantidade INT NOT NULL,
id_livro INT NOT NULL,
id_usuario INT NOT NULL,
CONSTRAINT fk_livro_movimentacao FOREIGN KEY (id_livro) REFERENCES Livros(id_livro) ON DELETE CASCADE,
CONSTRAINT fk_usuario_movimentacao FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario) ON DELETE RESTRICT
);

INSERT INTO Log_movimentacao_estoque (data_movimentacao, tipo, quantidade, id_livro, id_usuario) VALUES
('2024-01-10', 'ENTRADA', 10, 1, 1),
('2024-01-11', 'SAÍDA', 2, 2, 2),
('2024-01-12', 'ENTRADA', 5, 3, 3),
('2024-01-13', 'SAÍDA', 1, 4, 4),
('2024-01-14', 'ENTRADA', 20, 5, 5),
('2024-01-15', 'SAÍDA', 3, 6, 6),
('2024-01-16', 'ENTRADA', 8, 7, 7),
('2024-01-17', 'SAÍDA', 2, 8, 8),
('2024-01-18', 'ENTRADA', 15, 9, 9),
('2024-01-19', 'SAÍDA', 5, 10, 10);


-- Atividade 2
-- Atividade Prática 3

SELECT 
    CONCAT(nome, ' ', sobrenome) AS nome_completo, 
    email 
FROM Usuarios 
ORDER BY nome ASC;

SELECT 
    L.titulo, 
    E.quantidade_atual
FROM Livros AS L
INNER JOIN Estoque AS E ON L.id_livro = E.id_livro;

SELECT 
    U.nome AS nome_usuario, 
    L.titulo AS titulo_livro, 
    Log.quantidade, 
    Log.tipo AS tipo_movimentacao
FROM Log_movimentacao_estoque AS Log
INNER JOIN Usuarios AS U ON Log.id_usuario = U.id_usuario
INNER JOIN Livros AS L ON Log.id_livro = L.id_livro;

SELECT 
    L.titulo, 
    E.quantidade_atual
FROM Livros AS L
INNER JOIN Estoque AS E ON L.id_livro = E.id_livro
WHERE E.quantidade_atual < 5;

-- Atividade Prática 4

UPDATE Usuarios
SET sobrenome = 'Silva Souza'
WHERE id_usuario = 1;

UPDATE Estoque
SET quantidade_atual = quantidade_atual + 10
WHERE id_livro = 5;

UPDATE Usuarios
SET senha = '123456_temp'
WHERE email = 'contato@email.com';

UPDATE Estoque
SET quantidade_atual = 1
WHERE quantidade_atual = 0;

-- Atividade Prática 5

DELETE FROM Livros 
WHERE id_livro = 10;

DELETE FROM Livros
WHERE id_livro = 2;

DELETE FROM Usuarios 
WHERE id_usuario = 1;

DELETE FROM Log_movimentacao_estoque
WHERE tipo = 'Ajuste Temporário';

-- Conferindo
SELECT * FROM Livros WHERE id_livro = 10;
SELECT * FROM Livros WHERE id_livro = 2;