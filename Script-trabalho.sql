create table Usuario(
	id integer primary key autoincrement,
	nome varchar,
	nome_de_usuario varchar,
	endereco varchar,
	telefone varchar,
	email varchar,
	cpf integer,
	data_de_nascimento date
);

create table Categoria(
	id integer primary key autoincrement,
	nome varchar,
	descricao varchar
);

create table Produto(
	id integer primary key autoincrement,
	nome varchar,
	descricao varchar,
	quantidade_estoque integer increment,
	data_fabricacao date,
	valor_unitario double,
	codigo_vendedor integer not null,
	codigo_categoria integer not null,
	foreign key(codigo_vendedor) references Usuario (id),
	foreign key(codigo_categoria) references Categoria (id)
);

create table Pedido(
	id integer primary key autoincrement,
	data_de_compra date,
	codigo_comprador integer not null,
	codigo_vendedor integer not null,
	foreign key(codigo_comprador) references usuario(id),
	foreign key(codigo_vendedor) references pedido_produto(codigo_vendedor)
);


create table Pedido_produto(
	id integer primary key autoincrement,
	codigo_pedido integer,
	codigo_produto integer not null,
	codigo_vendedor integer not null,
	quantidade integer not null,
	foreign key(codigo_pedido) references pedido(id),
	foreign key(codigo_produto) references produto(id)
	foreign key(codigo_vendedor) references produto(codigo_vendedor)
);

--3. SQL de inserção de dados nas tabelas (pelo menos 5 registros emcada uma) (DML)

INSERT INTO usuario (nome, nome_de_usuario, endereco, telefone, email, cpf, data_de_nascimento) values
('Augusto Manuel Novaes', 'augustoMN', 'Avenida Murici, 103, Marabaixo, Macapá - AP', '(96)3740-8784', 'augusto-novaes92@engineer.com', '09739160603', 1975-02-11),
('Maya Valentina Duarte', 'mayduarte', 'Travessa J, 431, Coqueiro, Ananindeua - PA', '(91) 2592-0977', 'maya_duarte@tivit.com.br', '68660477499', 1961-04-26),
('Isabelly Marli Valentina Pinto', 'bellyMVP', 'Rua Rio Baurilha, 814, Vila Torres Galvão, Paulista - PE', '(81)3509-8483', 'isabelly.marli.pinto@statusseguros.com.br', '97158143449', 1984-02-15),
('Bertina Stefany da Rosa', 'tinarosa', 'Rua Silvandra Melo, 727, Outra Banda, Maranguape - CE', '(85)3637-8756', 'betinastefanydarosa@alphacandies.com.br', '76685151277', 1993-03-05),
('Thomas Levi Almeida', 'leviackerman', 'Quadra QR 221 Conjunto 3, 955, Samambaia Norte (Samanbaia), Brasilia - DF', '(61)3501-2466', 'thomas.levi.almeida@drimenezes.com', '79302390128', 1976-08-03);

INSERT INTO Categoria(nome, descricao) VALUES
('Informatica','Computadores, laptops, tablets e smartphones'),
('Livro', 'Ficção, não-ficção, biografias, romances e muito mais'),
('Roupas', 'Calças, camisas, vestidos, sapatos e acessórios'),
('Pet Shop', 'Alimentos, brinquedos, roupas e serviços para animais de estimação'),
('Cozinha', 'eletrodomésticos, utensílios, louças e decorações');

insert into Produto (nome, descricao, quantidade_estoque, data_fabricacao, valor_unitario, codigo_vendedor, codigo_categoria) values
('Teclado USB', 'Teclado com fio USB', '38', '2021-02-09', '22.50', 3, 1),
('O vendedor de sonhos', 'Augusto Cury, Primeiro lugar dos mais vendidos 2010', '150', '2010-12-28', '45.90', 5, 2),
('Casaco The North Face', 'Casaco térmico de proteção -5º', '380', '2018-03-15', '450.00', 1, 3),
('Coleira ZEEDOG', 'Coleira antipulgas', '270', '2020-08-07', '78.99', 4, 4),
('Processador de alimentos', 'Processa qualquer tipo de frutas e legumes', '892', '2022-04-31', '45.50', 2, 5); 

insert into pedido_produto (codigo_produto, codigo_pedido, codigo_vendedor, quantidade) values
(1, 1, 3, 2),
(3, 2, 1, 1),
(4, 3, 4, 3),
(2, 4, 5, 1),
(5, 5, 2, 1)

drop table Pedido_produto

INSERT INTO Pedido (data_de_compra, codigo_vendedor, codigo_comprador) values
('2023-10-08', 3, 5),
('2023-01-12', 1, 4),
('2023-07-09', 4, 1),
('2023-04-01', 5, 2),
('2023-03-23', 2, 3)

--4. Um comando SQL de atualização em algum registro em uma tabela
update Usuario set telefone = '(24)98823-9595' where id = 2;

--5. Um comando SQL de exclusão de algum registro em uma tabela
delete from Pedido where id = 2 

--6. a. Pelo menos 2 com algum tipo de junção
select u.nome vendedor, p.nome produto 
from Usuario u 
inner join Produto p on u.id = p.codigo_vendedor
group by u.nome


select u.nome comprador, pr.nome, pp.quantidade from Usuario u 
inner join Pedido p on u.id = p.codigo_comprador
inner join Pedido_produto pp on p.id = pp.codigo_pedido
inner join Produto pr on pr.id = pp.codigo_produto 
group by u.nome

--6. b. Pelo menos 1 com usando count() e group by()
select c.nome categoria, count(pr.id) Qtd_Produtos 
from Categoria c 
inner join Produto pr on c.id = pr.codigo_categoria 
group by c.nome


--6. c. Uma consulta livre
select * from Produto

--6 d. 1 SQL para construção de nota fiscal

select u1.nome vendedor, u2.nome comprador, u2.cpf, u2.telefone, pr.nome produto,
pp.quantidade, pr.valor_unitario
from Usuario u1
inner join Pedido p on u1.id = p.codigo_vendedor  
inner join Usuario u2 on u2.id = p.codigo_comprador 
inner join Pedido p2 on u2.id = p2.codigo_comprador
inner join Pedido_produto pp on pp.codigo_pedido  = p2.id
inner join Produto pr on pr.id = pp.codigo_produto
