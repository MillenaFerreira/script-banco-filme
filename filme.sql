#permite exibir todos os databases existentes
show databases;

#cria um database
create database db_videolocadora_tarde_20231;

# deleta um database
# drop database db_videolocadora_tarde_202031;

#permite selecionar o database que será utilizado
use db_videolocadora_tarde_20231;

#exibe todas as tabelas existentes no datatbe
show tables;

# TABELA : CLASSIFICAÇÃO
create table tbl_classificacao(
	id int not null auto_increment primary key,
    sigla varchar(5) not null,
    nome varchar(45) not null,
    descricao varchar(150) not null,
    
    unique index(id)
);

# TABELA : GENERO
create table tbl_genero(
	id int not null auto_increment primary key,
    nome varchar(100) not null,
    
    unique index(id)
);

# TABELA : SEXO
create table tbl_sexo(
	id int not null auto_increment primary key,
    nome varchar(50) not null,
    sigla varchar(5) not null,
    
    unique index(id)
);

# TABELA : NACIONALIDADE
create table tbl_nacionalidade(
	id int not null auto_increment primary key,
    nome varchar(45) not null,
    
    unique index(id)
);
#mostra todos atributos da tabela(os dois são utilizados para o mesmo fim)
desc tbl_nacionalidade;
describe tbl_nacionalidade;

###################### COMANDOS PARA ALTERAR UMA TABELA ##############################

#add column - adiciona uma nova coluna na tabela
alter table tbl_nacionalidade
	add column descricao varchar(50) not null;
        
alter table tbl_nacionalidade
	add column teste int,
    add column teste2 varchar(10) not null;

#drop column - exclui uma coluna da tabela
alter table tbl_nacionalidade
	drop column teste2;
    
#modify column - permite alterar a estrutura de uma coluna
alter table tbl_nacionalidade
	modify column teste varchar(5) not null;
    
#change - permite alterar a escrita e a sua estrutura
alter table tbl_nacionalidade
	change teste teste_nacionalidade int not null;

alter table tbl_nacionalidade
	change teste_nacionalidade teste_nacionalidade varchar(5) not null;
 
###################################################################################### 

#exclui uma tabela do database 
drop table tbl_nacionalidade;


################# CRIANDO TABELAS COM FK ###########################

create table tbl_filme(
	id int not null auto_increment primary key,
    nome varchar(100) not null,
    nome_original varchar(100) not null,
    data_lancamento date not null,
    data_relancamento date,
    duracao time not null,
    foto_capa varchar(150) not null,
    sinopse text not null,
    id_classificacao int not null,
    
    #é atribuido um nome ao processo de criar a FK
    constraint FK_Classificacao_Filme 
    #É o atributo desta tabela que será FK
    foreign key (id_classificacao)
    #Especifica de onde irá vir a FK
    references tbl_classificacao(id),
    
    unique index(id)
);
drop table tbl_filme;
desc tbl_filme;

create table tbl_filme_genero(
	id int not null auto_increment,
    id_filme int not null,
    id_genero int not null,
    
   # Relacionamento: Filme_FilmeGenero
   constraint FK_Filme_FilmeGenero
   foreign key (id_filme)
   references tbl_filme(id),
   
   # Relacionamento : Genero_FilmeGenero
   constraint FK_Genero_FilmeGenero
   foreign key(id_genero)
   references tbl_genero(id),
   
   primary key(id),
   unique index(id)
);
drop table tbl_filme_genero;
show tables;
desc tbl_filme_genero;

#Permite excluir uma constraint de uma tabela(
#somente podemos alterar a esstrutura de uma tabela
# que fornece um FK, se apagarmos a(s) sua(s) constrants)
alter table tbl_filme_genero
	drop foreign key FK_Genero_FilmeGenero;
  
#Permite criar uma constraint e suas relações em uma tabela já existente - reconstruindo a relação de filme e genero  
alter table tbl_filme_genero
		add constraint FK_Genero_FilmeGenero
			foreign key(id_genero)
            references tbl_genero(id);
    
 # TABELA : FILME_AVALIACAO   
create table tbl_filme_avaliacao(
	id int not null auto_increment primary key,
    nota float not null,
    comentario varchar(300) not null,
    id_filme int not null,
    
    # Relacionamento: Filme_FilmeAvaliacao
   constraint FK_Filme_Avaliacao
   foreign key (id_filme)
   references tbl_filme(id)

);    
desc tbl_filme_avaliacao;

alter table tbl_filme_avaliacao
	add unique index(id);

# TABELA : DIRETOR
create table tbl_diretor(
	id int not null auto_increment primary key,
    nome varchar(100) not null,
    nome_artistico varchar(100),
    data_nascimento date not null,
    biografia text not null,
    foto varchar(150) not null,
    data_falecimento date,
    id_sexo int not null,
    
	# Relacionamento: Filme_FilmeAvaliacao
   constraint FK_Sexo_Diretor
   foreign key (id_sexo)
   references tbl_sexo(id),
   
   unique index(id)
);

desc tbl_diretor;

# TABELA : DIRETOR_NASCIONALIDADE
create table tbl_diretor_nacionalidade(
	id int not null auto_increment primary key,
    id_diretor int not null,
    id_nacionalidade int not null,
    
   # Relacionamento: Diretor_DiretorNacionalidade
   constraint FK_Diretor_DiretorNacionalidade
   foreign key (id_diretor)
   references tbl_diretor(id),
   
   # Relacionamento : Nascionalidade_DiretorNascionalidade
   constraint FK_Nacionalidade_DiretorNacionalidade
   foreign key(id_nacionalidade)
   references tbl_nacionalidade(id),
   
   unique index(id)
);

desc tbl_diretor_nacionalidade;

# TABELA : FILME_DIRETOR
create table tbl_filme_diretor(
	id int not null auto_increment primary key,
    id_diretor int not null,
    id_filme int not null,
    
   # Relacionamento: Filme_FilmeDiretor
   constraint FK_Filme_FilmeDiretor
   foreign key (id_filme)
   references tbl_filme(id),
   
   # Relacionamento : Diretor_FilmeDiretor
   constraint FK_Diretor_FilmeDiretor
   foreign key(id_diretor)
   references tbl_diretor(id),
   
   unique index(id)
);

desc tbl_filme_diretor;

# TABELA : ATOR
create table tbl_ator(
	id int not null auto_increment primary key,
    nome varchar(100) not null,
    nome_artistico varchar(100),
    data_nascimento date not null,
    biografia text not null,
    foto varchar(150) not null,
    data_falecimento date,
    id_sexo int not null,
    
    # Relacionamento: Sexo_Ator
   constraint FK_Sexo_Ator
   foreign key (id_sexo)
   references tbl_sexo(id),
   
   unique index(id)
);

desc tbl_ator;

# TABELA : ATOR_NACIONALIDADE
create table tbl_ator_nacionalidade(
	id int not null auto_increment primary key,
    id_ator int not null,
    id_nacionalidade int not null,
    
   # Relacionamento: Ator_AtorNacionalidade
   constraint FK_Ator_AtorNacionalidade
   foreign key (id_ator)
   references tbl_ator(id),
   
   # Relacionamento : Nascionalidade_AtorNacionalidade
   constraint FK_Nacionalidade_AtorNacionalidade
   foreign key(id_nacionalidade)
   references tbl_nacionalidade(id),
   
   unique index(id)
);

desc tbl_ator_nacionalidade;

# TABELA: FILME_ATOR
create table tbl_filme_ator (
	id int not null auto_increment primary key,
    id_filme int not null,
    id_ator int not null,
    
    # Relacionamento : Filme_FilmeAtor
    constraint FK_Filme_FilmeAtor
    foreign key (id_filme)
    references tbl_filme(id),
    
    #Relacionamento : Ator_FilmeAtor
    constraint FK_Ator_FilmeAtor
    foreign key (id_ator)
    references tbl_ator(id),
    
    unique index (id)
);

desc tbl_filme_ator;

########Inserir dados nas tabelas#############

###############TABELA: GENERO###################
#INSERT
insert into tbl_genero(nome) values ('Policial');
insert into tbl_genero(nome) values ('Drama');

#Exemplos de insert com multiplos valores
insert into tbl_genero(nome) values ('Comédia'),
								    ('Romance');                                    
insert into tbl_genero(nome) values ('Aventura'),
								    ('Animação'),
                                    ('Musical');
insert into tbl_genero(nome) values ('Fantasia'),
								    ('Ação'),
                                    ('Suspense');
                                    
select * from tbl_genero;

#UPDATE
#sem where (dá ruim)
update tbl_genero set nome = 'Comedia';
#com o where (show de bola)
update tbl_genero set nome = 'Comédia' where id = 3;

#DELETE
delete from tbl_genero;

################TABELA: CLASSIFICAÇÃO##############

insert into tbl_classificacao(sigla, nome, descricao) values ('L', 'Livre', 'Não expõe crianças a conteúdo potencialmente prejudiciais'),
															 ('10', 'Não recomendado para menores de 10 anos','Conteúdo violento ou linguagem inapropriado para crianças, ainda que em menor intensividade'),
															 ('12', 'Não recomendado para menores de 12 anos','As cenas podem conter agressão física, consumo de drogas e insinuação sexual'),
															 ('14', 'Não recomendado para menores de 14 anos','Conteúdo mais violentos e/ou de linguagem sexual mais acentuada'),
															 ('16', 'Não recomendado para menores de 16 anos','Conteúdo mais violentos ou com contéudo sexual mais intenso com cenas de tortura, suicídio, estrupro ou nudez total'),
															 ('18', 'Não recomendado para menores de 18 anos','Conteúdo violentos e sexuais extremos.Cenas de sexo, incesto ou atos repetidos de tortura, mutilação ou abuso sexual');
                                                             
                                                             
select * from tbl_classificacao;
        
        
##################TABELA: FILME #####################

insert into tbl_filme(
						nome,
                        nome_original,
                        data_lancamento,
                        data_relancamento,
                        duracao,
                        foto_capa,
                        sinopse,
                        id_classificacao
                        ) values (
                        'O Poderoso Chefão',
                        'The Godfather',
                        '1972-03-24',
                        '2022-02-24',
                        '02:55:00',
                        'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/90/93/20/20120876.jpg',
                        'Don Vito Corleone (Marlon Brando) é o chefe de uma "família" de Nova York que está feliz, pois Connie (Talia Shire), sua filha, se casou com Carlo (Gianni Russo). Porém, durante a festa, Bonasera (Salvatore Corsitto) é visto no escritório de Don Corleone pedindo "justiça", vingança na verdade contra membros de uma quadrilha, que espancaram barbaramente sua filha por ela ter se recusado a fazer sexo para preservar a honra. Vito discute, mas os argumentos de Bonasera o sensibilizam e ele promete que os homens, que maltrataram a filha de Bonasera não serão mortos, pois ela também não foi, mas serão severamente castigados. Vito porém deixa claro que ele pode chamar Bonasera algum dia para devolver o "favor". Do lado de fora, no meio da festa, está o terceiro filho de Vito, Michael (Al Pacino), um capitão da marinha muito decorado que há pouco voltou da 2ª Guerra Mundial. Universitário educado, sensível e perceptivo, ele quase não é notado pela maioria dos presentes, com exceção de uma namorada da faculdade, Kay Adams (Diane Keaton), que não tem descendência italiana mas que ele ama. Em contrapartida há alguém que é bem notado, Johnny Fontane (Al Martino), um cantor de baladas românticas que provoca gritos entre as jovens que beiram a histeria. Don Corleone já o tinha ajudado, quando Johnny ainda estava em começo de carreira e estava preso por um contrato com o líder de uma grande banda, mas a carreira de Johnny deslanchou e ele queria fazer uma carreira solo. Por ser seu padrinho Vito foi procurar o líder da banda e ofereceu 10 mil dólares para deixar Johnny sair, mas teve o pedido recusado. Assim, no dia seguinte Vito voltou acompanhado por Luca Brasi (Lenny Montana), um capanga, e após uma hora ele assinou a liberação por apenas mil dólares, mas havia um detalhe: nas "negociações" Luca colocou uma arma na cabeça do líder da banda. Agora, no meio da alegria da festa, Johnny quer falar algo sério com Vito, pois precisa conseguir o principal papel em um filme para levantar sua carreira, mas o chefe do estúdio, Jack Woltz (John Marley), nem pensa em contratá-lo. Nervoso, Johnny começa a chorar e Vito, irritado, o esbofeteia, mas promete que ele conseguirá o almejado papel. Enquanto a festa continua acontecendo, Don Corleone comunica a Tom Hagen (Robert Duvall), seu filho adotivo que atua como conselheiro, que Carlo terá um emprego mas nada muito importante, e que os "negócios" não devem ser discutidos na sua frente. Os verdadeiros problemas começam para Vito quando Sollozzo (Al Lettieri), um gângster que tem apoio de uma família rival, encabeçada por Phillip Tattaglia (Victor Rendina) e seu filho Bruno (Tony Giorgio). Sollozzo, em uma reunião com Vito, Sonny e outros, conta para a família que ele pretende estabelecer um grande esquema de vendas de narcóticos em Nova York, mas exige permissão e proteção política de Vito para agir. Don Corleone odeia esta idéia, pois está satisfeito em operar com jogo, mulheres e proteção, mas isto será apenas a ponta do iceberg de uma mortal luta entre as "famílias".',
                        4
                        );
                        
insert into tbl_filme(
						nome,
                        nome_original,
                        data_lancamento,
                        data_relancamento,
                        duracao,
                        foto_capa,
                        sinopse,
                        id_classificacao
                        ) values (
                        'Forrest Gump - O contador de história',
                        'Forrest Gump',
                        '1994-12-07',
                        null ,
                        '02:20:00',
                        'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/87/30/21/19874092.jpg',
                        'Quarenta anos da história dos Estados Unidos, vistos pelos olhos de Forrest Gump (Tom Hanks), um rapaz com QI abaixo da média e boas intenções. Por obra do acaso, ele consegue participar de momentos cruciais, como a Guerra do Vietnã e Watergate, mas continua pensando no seu amor de infância, Jenny Curran.',
                        4
                        );

insert into tbl_filme(
						nome,
                        nome_original,
                        data_lancamento,
                        data_relancamento,
                        duracao,
                        foto_capa,
                        sinopse,
                        id_classificacao
                        ) values (
                        'O Rei Leão',
                        'The Lion King',
                        '1994-07-08',
                        '2011-08-26' ,
                        '01:29:00',
                        'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/87/84/28/19962110.jpg',
                        'Clássico da Disney, a animação acompanha Mufasa (voz de James Earl Jones), o Rei Leão, e a rainha Sarabi (voz de Madge Sinclair), apresentando ao reino o herdeiro do trono, Simba (voz de Matthew Broderick). O recém-nascido recebe a bênção do sábio babuíno Rafiki (voz de Robert Guillaume), mas ao crescer é envolvido nas artimanhas de seu tio Scar (voz de Jeremy Irons), o invejoso e maquiavélico irmão de Mufasa, que planeja livrar-se do sobrinho e herdar o trono.',
                        1
                        );


insert into tbl_filme(
						nome,
                        nome_original,
                        data_lancamento,
                        data_relancamento,
                        duracao,
                        foto_capa,
                        sinopse,
                        id_classificacao
                        ) values (
                        'À espera de um milagre',
                        'The Green Mile',
                        '1994-07-10',
                        null ,
                        '03:09:00',
                        'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/91/66/66/20156966.jpg',
                        '1935, no corredor da morte de uma prisão sulista. Paul Edgecomb (Tom Hanks) é o chefe de guarda da prisão, que temJohn Coffey (Michael Clarke Duncan) como um de seus prisioneiros. Aos poucos, desenvolve-se entre eles uma relação incomum, baseada na descoberta de que o prisioneiro possui um dom mágico que é, ao mesmo tempo, misterioso e milagroso.',
                        4
                        );
                        
insert into tbl_filme(
						nome,
                        nome_original,
                        data_lancamento,
                        data_relancamento,
                        duracao,
                        foto_capa,
                        sinopse,
                        id_classificacao
                        ) values (
                        'Batman - o Cavaleiro das Trevas',
                        'The Dark Knight',
                        '2008-07-18',
                        null ,
                        '02:32:00',
                        'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/86/98/32/19870786.jpg',
                        'Após dois anos desde o surgimento do Batman (Christian Bale), os criminosos de Gotham City têm muito o que temer. Com a ajuda do tenente James Gordon (Gary Oldman) e do promotor público Harvey Dent (Aaron Eckhart), Batman luta contra o crime organizado. Acuados com o combate, os chefes do crime aceitam a proposta feita pelo Coringa (Heath Ledger) e o contratam para combater o Homem-Morcego.',
                        3
                        );   
                        
insert into tbl_filme(
						nome,
                        nome_original,
                        data_lancamento,
                        data_relancamento,
                        duracao,
                        foto_capa,
                        sinopse,
                        id_classificacao
                        ) values (
                        'À espera de um milagre',
                        'Avengers: Endgame',
                        '2019-04-25',
                        '2019-07-11' ,
                        '03:01:00',
                        'https://br.web.img2.acsta.net/c_310_420/pictures/19/04/26/17/30/2428965.jpg',
                        'Em Vingadores: Ultimato, após Thanos eliminar metade das criaturas vivas em Vingadores: Guerra Infinita, os heróis precisam lidar com a dor da perda de amigos e seus entes queridos. Com Tony Stark (Robert Downey Jr.) vagando perdido no espaço sem água nem comida, o Capitão América/Steve Rogers (Chris Evans) e a Viúva Negra/Natasha Romanov (Scarlett Johansson) precisam liderar a resistência contra o titã louco.',
                        3
                        );                        
update tbl_filme set nome = 'Vingadores: Ultimato' where id =  6;                      
                                                             
select * from tbl_filme;       

####### TABELA DE RELAÇÃO ENTRE FILME E GENERO FILME_GENERO ############    

#o poderoso chefão
insert into tbl_filme_genero (id_filme, id_genero) values(1, 8), (1, 9);

#forrest gump
insert into tbl_filme_genero (id_filme, id_genero) values(2, 11), (2, 9), (2, 10);

#rei leão
insert into tbl_filme_genero (id_filme, id_genero) values(3, 13), (3, 12), (3, 14);

#a espera de um milagre
insert into tbl_filme_genero (id_filme, id_genero) values(4, 15), (4, 8); 

#batman
insert into tbl_filme_genero (id_filme, id_genero) values(5, 16), (5, 17);

#vingadores
insert into tbl_filme_genero (id_filme, id_genero) values(6, 16), (6, 15), (6, 12);

select * from tbl_filme_genero;      


####### TABELA: SEXO ##########
insert into tbl_sexo(nome,sigla) values ('Masculino', 'M');
insert into tbl_sexo(nome,sigla) values ('Feminino', 'F');

select * from tbl_sexo;

############ TABELA: AUTOR #############

insert into tbl_ator (
						nome,
                        nome_artistico,
                        data_nascimento,
                        biografia,
                        foto,
                        data_falecimento,
                        id_sexo
                        ) values (
                        'Marlon Brando Jr',
                        'Marlon Brando',
                        '1924-04-03',
                        '- Trabalhou como ascensorista de elevador em uma loja por 4 dias, antes de se tornar famoso.

- Possui uma ilha particular no oceano Pacífico, na Polinésia, desde 1966.

- O Oscar que ganhou por "Sindicato dos Ladrões" foi roubado de sua casa, com o ator tendo solicitado à Academia de Artes e Ciências Cinematográficas a reposição da estatueta, em 1970.

- Recusou o Oscar recebido por "O Poderoso Chefão", em protesto pelo modo como os Estados Unidos e, especialmente, Hollywood vinham discriminando os índios nativos do país. Brando não compareceu à cerimônia de entrega do Oscar e enviou em seu lugar a atriz Sacheen Littlefeather, que subiu ao palco para receber a estatueta do ator como se fosse uma índia verdadeira, divulgando seu protesto.

- Em determinado momento das filmagens de "A Cartada Final", se recusava a estar no mesmo set que o diretor Frank Oz.

- Possui uma estrela na Calçada da Fama, localizada em 1777 Vine Street.',
                        'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/87/51/54/20040663.jpg',
                        '2004-07-01',
                        1
                        );
                        
insert into tbl_ator (
						nome,
                        nome_artistico,
                        data_nascimento,
                        biografia,
                        foto,
                        data_falecimento,
                        id_sexo
                        ) values (
                        'Alfredo James Pacino',
                        'Al Pacino',
                        '1940-04-25',
                        '- É um grande fã de ópera;- É um dos poucos astros de Hollywood que nunca casou;- Foi preso em janeiro de 1961, acusado de carregar consigo uma arma escondida;- Recusou o personagem Han Solo, da trilogia original de "Star Wars";- Foi o primeiro na história do Oscar a ser indicado no mesmo ano nas categorias de melhor ator e melhor ator coadjuvante.',
                        'https://br.web.img3.acsta.net/c_310_420/pictures/19/03/19/18/33/1337912.jpg',
                        null,
                        1
						);                        
                        
insert into tbl_ator (
						nome,
                        nome_artistico,
                        data_nascimento,
                        biografia,
                        foto,
                        data_falecimento,
                        id_sexo
                        ) values (
                        'Thomas Jeffrey Hanks',
                        'Tom Hanks',
                        '1956-07-09',
                        'Tom Hanks iniciou a carreira no cinema aos 24 anos, com um papel no filme de baixo orçamento Trilha de Corpos. Logo migrou para a TV, onde estrelou por dois anos a série Bosom Buddies. Nela passou a trabalhar com comédia, algo com o qual não estava habituado, rendendo convites para pequenas participações nas séries Táxi, Caras & Caretas e Happy Days.

Em 1984, veio seu primeiro sucesso no cinema: a comédia Splash - Uma Sereia em Minha Vida, na qual era dirigido por Ron Howard e contracenava com Daryl Hannah. Em seguida vieram várias comédias, entre elas A Última Festa de Solteiro (1984), Um Dia a Casa Cai (1986) e Dragnet - Desafiando o Perigo (1987), tornando-o conhecido do grande público.

Com Quero Ser Grande (1988) Hanks obteve sua primeira indicação ao Oscar de melhor ator. Apesar de consagrado como comediante, aos poucos passou a experimentar outros gêneros. Em 1993 surpreendeu em Filadélfia como um advogado homossexual que luta na justiça contra sua demissão, motivada por preconceito devido a ele ser portador do vírus da AIDS. Pelo papel conquistou seu primeiro Oscar.

Já no ano seguinte Hanks ganharia sua segunda estatueta dourada, repetindo um feito apenas obtido por Spencer Tracy, quase 60 anos antes. Forrest Gump - O Contador de Histórias foi sucesso de público e crítica, ganhando seis Oscar.

Estabelecido como um dos maiores astros de Hollywood, Hanks passou a emendar um sucesso atrás do outro: Apollo 13 - Do Desastre ao Triunfo (1995), Toy Story (1995), O Resgate do Soldado Ryan (1998), Mens@gem Para Você (1998), Toy Story 2 (1999), À Espera de um Milagre (1999), Náufrago (2000), Prenda-me Se For Capaz (2002) e Estrada para Perdição (2002).

Em 1996, resolveu se dedicar à sua estreia na direção. O resultado foi The Wonders - O Sonho Não Acabou, divertida comédia que rendeu a contagiante música "That Thing You Do!". Hanks voltaria a trabalhar como diretor em episódios das séries de TV Da Terra à Lua (1998) e Band of Brothers (2001) e também na comédia romântica Larry Crowne - O Amor Está de Volta (2011).

Em 2004, o ator encampou a ideia de interpretar vários personagens na animação O Expresso Polar, dirigida pelo colega Robert Zemeckis. Usando o método de captura de movimento, Hanks interpretou seis personagens de idades variadas.

Um de seus personagens mais famosos é o simbologista Robert Langdon, criado pelo autor Dan Brown. Hanks o interpretou em dois filmes, O Código Da Vinci (2006) e Anjos e Demônios (2009).',
                        'https://br.web.img3.acsta.net/c_310_420/pictures/18/08/08/18/47/1167635.jpg',
                        null,
                        1
						);
                        
insert into tbl_ator (
						nome,
                        nome_artistico,
                        data_nascimento,
                        biografia,
                        foto,
                        data_falecimento,
                        id_sexo
                        ) values (
                        'Gary Alan Sinise',
                        'Gary Sinise',
                        '1955-03-17',
                        'Sinise é conhecido por vários papéis ​​durante sua carreira, como o de George Milton na adaptação cinematográfica de De Ratos e Homens, o tenente Dan Taylor em Forrest Gump, pelo qual foi nomeado para o Oscar de melhor ator coadjuvante, Harry S. Truman em Truman (filme de 1995), pelo qual ganhou um Globo de Ouro, Ken Mattingly em Apollo 13, o detetive Jimmy Shaker em Ransom, e George C. Wallace no filme de televisão George Wallace, pelo qual foi premiado com um Emmy do Primetime. Em abril de 2017, Gary foi agraciado com uma estrela na calçada da fama de Hollywood. A cerimônia contou as participações do ator Joe Mantegna da série Criminal Minds.

É também integrante da banda Lt. Dan Band, que atua em prol da caridade e de associações sem fins lucrativos, onde toca baixo. O nome Lieutenant Dan ou tenente Dan vem do personagem de Gary no filme Forrest Gump (tenente Dan Taylor), que contracenou com Tom Hanks como o amigo salvo por Forrest durante a Guerra do Vietnam.

Em janeiro de 2015, foi confirmado no spin-off da série Criminal Minds, no papel do chefe da equipe, Jack Garrett, com vinte anos de experiência na Unidade de Análise Comportamental do FBI. Junto de Sinise, outros dois nomes foram confirmados: Tyler James Williams (Todo Mundo Odeia o Chris e The Walking Dead) e Anna Gunn (Breaking Bad).',
                        'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/92/45/36/20200745.jpg',
                        null,
                        1
						);
                        
insert into tbl_ator (
						nome,
                        nome_artistico,
                        data_nascimento,
                        biografia,
                        foto,
                        data_falecimento,
                        id_sexo
                        ) values (
                        'GARCIA JÚNIOR',
                        null,
                        '1967-03-02',
                        'Manoel "Manny" Garcia Júnior nasceu em 1967, na cidade de São Paulo, filho dos dubladores Garcia Neto e Dolores Machado. Sua primeira participação na televisão foi aos 2 anos no programa de TV de Omar Cardoso, um astrólogo, em 1969, onde seu pai era produtor, e o colocou para fazer parte do programa como um cupido. Tendo passado a infância em teatros, estúdios de rádio e de dublagem onde os pais trabalhavam, aos 10 anos entrou para o ramo na BKS, porque o dublador que fazia a voz do Pica-Pau, Olney Cazarré, teve que ir ao Rio de Janeiro, para fazer parte de uma novela, e Garcia Neto, ao assumir a direção, testou o filho no papel. Em 1982 Garcia Júnior e seus pais se mudaram para o Rio de Janeiro, e eles passaram a dublar na Herbert Richers, na Telecine e na VTI Rio.[5][6] Em 1985 Garcia Júnior passou a fazer o personagem título da serie He-Man, um de seus papéis de mais destaques. Em 1988 García Júnior passou a fazer a voz do ator Arnold Schwarzenegger. Em 1991 Garcia Júnior passou a traduzir e dirigir dublagens inicialmente na Herbert Richers. Em 1994 Garcia Júnior se tornou diretor de criação da parte brasileira da Disney e passou a trabalhar no estúdio de dublagem Delart. Em 1996 Garcia Neto, o pai de Garcia Júnior, faleceu de um câncer. Em 1999 Garcia Júnior dirigiu o longa metragem Toy Story 2, dando sequência a Toy Story, que foi dirigido por seu pai, Garcia Neto. Em 2004 Dolores Machado, a mãe de García Júnior, se aposentou da dublagem. Em 2005 Garcia Júnior parou de dublar na Herbert Richers, passando a dublar mais na Delart. Em 2008 Garcia Júnior se afastou um pouco da dublagem, e passou a se dedicar apenas para sua trabalhos da Disney. Em 2010 Garcia Júnior dirigiu a dublagem de Toy Story 3, onde dublou o personagem Espeto. Em 2011 Garcia Júnior foi demitido de seu cargo na Disney. Em 2012 García Júnior voltou a dublar mais na Double Sound, e na Wan Macher, mas principalmente na Delart, e faz isso até hoje em dia.',
                        'https://br.web.img2.acsta.net/c_310_420/pictures/14/01/16/13/52/556410.jpg',
                        null,
                        1
						);
                        
insert into tbl_ator (
						nome,
                        nome_artistico,
                        data_nascimento,
                        biografia,
                        foto,
                        data_falecimento,
                        id_sexo
                        ) values (
                        'MATTHEW BRODERICK',
                        null,
                        '1962-03-21',
                        'Matthew Broderick começou a carreira de ator no teatro, com diversas aparições na Broadway, que lhe renderam dois prêmios Tony. Em seguida o ator fez sua estreia na televisão. Seu primeiro filme foi A Volta de Max Dugan (1983). Seu primeiro papel de sucesso no cinema foi em Curtindo a Vida Adoidado (1986).
Desde então, Broderick segue atuando no teatro, na televisão e no cinema. Além disso, o ator já dublou diversos personagens de animação, como em O Rei Leão (1994) e Bee Movie: A História de uma Abelha (2007). 
',
                        'https://br.web.img2.acsta.net/c_310_420/pictures/19/07/02/22/47/0236519.jpg',
                        null,
                        1
						);
                        
                        
insert into tbl_ator (
						nome,
                        nome_artistico,
                        data_nascimento,
                        biografia,
                        foto,
                        data_falecimento,
                        id_sexo
                        ) values (
                        'MICHAEL CLARKE DUNCAN',
                        'Michael Duncan',
                        '1957-12-10',
                        'Michael Clarke Duncan é conhecido pela atuação em À Espera de um Milagre, que lhe rendeu indicações ao Oscar e ao Globo de Ouro de Melhor Ator Coadjuvante. Fez sua estreia nos cinemas em 1995, com um papel não creditado em Sexta-Feira em Apuros. O primeiro trabalho de destaque viria três anos depois com Armageddon. Agradou tanto que Bruce Willis recomendou que Frank Darabont contratasse ele para À Espera de um Milagre, em 1999.

Muitas vezes tratado como Big Mike, por causa da altura de 1,96 m, o ator se destacou ainda em Meu Vizinho Mafioso, Planeta dos Macacos, O Escorpião Rei e A Ilha. Participou também de três adaptações dos quadrinhos: O Demolidor, Sin City - A Cidade do Pecado e Lanterna Verde. Robert Rodriguez contava com o retorno dele para Sin City 2: A Dame to Kill For, algo que infelizmente não irá mais acontecer.

Na TV, Clarke Duncan contou com participações em importantes seriados, como Um Maluco no Pedaço, Bones, Chuck e Two and a Half Men. Faleceu em setembro de 2012, aos 54 anos, após passar dois meses hospitalizado em Los Angeles.
',
                        'https://br.web.img3.acsta.net/c_310_420/pictures/14/09/06/19/41/147683.jpg',
                        '2012-07-03',
                        1
						);                         
                        
                        
                        
insert into tbl_ator (
						nome,
                        nome_artistico,
                        data_nascimento,
                        biografia,
                        foto,
                        data_falecimento,
                        id_sexo
                        ) values (
                        'Christian Charles Philip Bale',
                        'CHRISTIAN BALE',
                        '1974-01-30',
                        'Caçula de três irmãs mais velhas, filho de um piloto de aviação comercial e de uma dançarina de circo, Bale começou a atuar por influência de uma delas. Pouca gente recorda que este ator inglês é o menino Jim, que tocou corações em Império do Sol (1987), de Steven Spielberg. Para ganhar o papel, derrotou cerca de quatro mil candidatos e sua atuação ainda rendeu prêmios.

Mesmo tendo começado cedo (aos 9 anos fez seu primeiro comercial de cereais), foi somente com Psicopata Americano (2000) que ganhou mais notoriedade no papel de Patrick Bateman, que seria, incialmente, de Leonardo DiCaprio.

Sua dedicação ao trabalho é reconhecida e sua "entrega" para viver Trevor em O Operário (2004), quando emagreceu cerca de 30 kg, foi considerada chocante demais.

Famoso por sua aversão a entrevistas, Bale é capaz de concedê-las com seu bom sotaque americano apenas para não confundir o público, caso o filme em questão seja de um personagem americano.

Curiosamente, dois personagens famosos de sua galeria começam com a primeira letra de seu sobrenome: Bateman e Batman. Ao lado de Michael Keaton, foi o segundo ator a viver mais de uma vez o personagem no cinema, o primeiro não americano e o mais jovem. Em 2011, com O Vencedor (2010) tornou-se o segundo intérprete do homem-morcego a faturar o Oscar. O outro tinha sido George Clooney, por Syriana - A Indústria do Petróleo (2005).

Reservado sobre sua vida pessoal, Bale é casado desde 2000 e tem uma filha, Emmaline Bale, nascida em 2005. Chegou a ser vegetariano, mas voltou a comer carne. Adora ler, é fã do jogo Mario Bros., apaixonado  por animais e defensor de causas sociais, constuma se envolver em organizações como Greenpeace e Dian Fossey Gorilla Fun, entre outros.
 
',
                        'https://br.web.img3.acsta.net/c_310_420/pictures/15/02/24/18/43/126776.jpg',
                        null,
                        1
						);
                        


insert into tbl_ator (
						nome,
                        nome_artistico,
                        data_nascimento,
                        biografia,
                        foto,
                        data_falecimento,
                        id_sexo
                        ) values (
                        'Heathcliff Andrew Ledger',
                        'HEATH LEDGER',
                        '1979-04-04',
                        'Extremamente tímido, este australiano descendente de irlandeses e escoceses optou por atuar desde cedo. Mesmo com a rápida fama conquistada, em parte por sua beleza, ele procurou interpretar papéis que não explorassem este aspecto e conseguiu atuações marcantes em sua curta carreira. Premiado após sua morte pela atuação como Coringa, Ledger tem seu lugar marcado para sempre na história do cinema mundial. (RC)',
                        'https://br.web.img2.acsta.net/c_310_420/pictures/18/08/16/19/43/2593099.jpg',
                        '2008-01-22',
                        1
						);

                        

insert into tbl_ator (
						nome,
                        nome_artistico,
                        data_nascimento,
                        biografia,
                        foto,
                        data_falecimento,
                        id_sexo
                        ) values (
                        'Robert John Downey Jr',
                        'ROBERT DOWNEY JR.ROBERT DOWNEY JR.',
                        '1965-04-04',
                        'Do céu ao inferno e ao céu novamente. Se alguém pensou no mito do pássaro fênix que renasce das cinzas, até que a comparação poderia se encaixar para definir este brilhante ator que já deu vida para personagens tão distantes em tempo e estilo, como Charles Chaplin (Chaplin - 1992) e Tony Stark (Homem de Ferro - 2008).

Na ativa por mais de quatro décadas e dono de uma voz grave, afinada, Downey já dublou desenho animado (God, the Devil and Bob - 2000), se aventurou no mundo da música, em 2004, com o disco The Futurist (Sony) e fez bonito na televisão, onde faturou o Globo de Ouro, além de outros prêmios e indicações por Larry Paul, personagem do seriado Ally McBeal (2000 - 2002).

Mas é no cinema que sua estrela parece brilhar mais intensamente. Tendo estreado aos cinco anos de idade, em 1970, dirigido pelo pai em Pound e repetido a experiência outras vezes, como aconteceu em Hugo Pool (1997), o reconhecimento e ápice do sucesso veio em 2008 na pele do herói metálico e em Trovão Tropical, pelo qual foi indicado ao Oscar, entre outros prêmios.

Descendente de irlandeses, escoceses, judeus e alemães, esse filho de pais separados (aos 11 anos) perdeu boa parte de sua infância devido ao trabalho de cineasta independente exercido por seu pai, que o fazia ficar para lá e para cá, entre Estados Unidos, Paris, Londres etc.

Aos 17 anos, largou os estudos e se mudou para Nova York para se tornar ator, tendo trabalhado por lá em restaurantes, lojas de sapatos e fazendo performances artísticas nos inferninhos do SohHo.

Casado de 1992 até 2004 com Deborah Falconer, eles atuaram juntos em Short Cuts - Cenas da Vida (1993) e com ela teve um filho chamado Indio Falconer Downey, nascido em 1993. Em 2005, casou-se com a produtora Susan Downey, que conheceu nos bastidores do suspense Na Companhia do Medo (2003), e o primeiro filho do casal nasce em 2012. Sting e Billy Idol cantaram na cerimônia de casamento.

Do passado que prefere esquecer, ficam as passagens pela prisão (violência, posse de drogas, armas) e visitas a clínicas de reabilitação no final dos anos 90, momentos que culminaram com sua demissão do seriado Ally McBeal, quase derrubaram de vez a sua carreira, mas foram devidamente superados para a alegria dos fãs.

Do Oriente, tradicional celeiro das artes marciais, encontrou um dos caminhos para abandonar as drogas e ter uma vida mais saudável, praticando o Wing Chun, em 2003, e anos mais tarde, seu mestre da arte marcial chinesa serviria com consultor para Guy Ritchie realizar Sherlock Holmes (2009). No Japão, porém, seu passado o impediu de entrar no país para divulgar Homem de Ferro, algo que só aconteceu horas de interrogatório e conversações. 

Curiosamente, antes de brilhar como o herói Homem de Ferro, ele trabalhou com três outros parceiros, que já tinham dado vida a heróis dos quadrinhos: George Clooney em Boa Noite e Boa Sorte (2005), Val Kilmer em Beijos e Tiros (2005) e Michael Keaton em Game 6 (2005).

Além disso, ele foi o primeiro ator que fez parte do elenco regular do programa humorístico Saturday Night Live a ser indicado ao Oscar mna categoria Melhor Ator. Ele é também o único ator a receber um Globo de Ouro interpretando Sherlock Holmes.

Eleito em 2008 como uma das 100 pessoas mais influentes do mundo pela tradicional revista Time, Downey Jr. mantém entre suas marcas registradas o humor sarcástico e um jeito peculiar de interpretar personagens "ego-excêntricos".

Em 2010, este fã de Peter OToole (Lawrence da Arábia), ex-namorado de Sarah Jessica Parker (por sete anos) e colega de quarto de Kiefer Sutherland nos anos 80, ganhou sua estrela na tradicional Calçada da Fama, em Los Angeles. diante do Graumans Chinese, nos Estados Unidos.

A homenagem é mais do que merecida para alguém que soube cair e se levantar, sem nunca deixar de lado o talento para entreter o espectador ao redor do planeta. Para os brasileiros, o ator deu o ar da graça em uma preimère realizada no Rio de Janeiro, em 9 de janeiro de 2012, para lançar Sherlock Holmes - O Jogo de Sombras (2011).',
                        'https://br.web.img3.acsta.net/c_310_420/pictures/18/06/29/00/35/0101925.jpg',
                        null,
                        1
						);


insert into tbl_ator (
						nome,
                        nome_artistico,
                        data_nascimento,
                        biografia,
                        foto,
                        data_falecimento,
                        id_sexo
                        ) values (
                        'Christopher Robert Evans',
                        'CHRIS EVANS',
                        '1981-06-13',
                        'Depois de uma infância e estudos ​​em Boston, Chris Evans decidiu ir para Nova York para tentar a sorte na comédia. Ele rapidamente consegue entrar na profissão, principalmente participando em séries de televisão (Boston Public). Sua carreira no cinema começou em 2001, em uma comédia para adolescentes (Não é Mais um Besteirol Americano). Mas sem ficar preso a apenas um gênero de filme, o ator vai para outras produções: trapaceia nas provas com Scarlett Johansson na comédia policial Nota Máxima (2004), interpreta o papel de Kim Basinger no thriller Celular - Um Grito de Socorro (2004) e seduz Jessica Biel em London (2005).


O destino de Chris Evans como o conhecemos hoje começou em 2005, quando ele conseguiu seu primeiro papel como super-herói. Em Quarteto Fantástico, um sucesso de bilheteria adaptado dos quadrinhos da Marvel, ele interpreta Johnny Storm, também conhecido como Tocha Humana. O filme é um sucesso e tem uma sequência dois anos depois (O Quarteto Fantástico e o Surfista Prateado). Para se manter na mesm a linha de superheróis, ele empresta sua voz no filme das Tartarugas Ninja (2007), descobre habilidades sobre-humanas em Heróis (2009) e luta no delirante Scott Pilgrim contra o Mundo (2010). No mesmo ano, ele assume a pele de um ex-agente renegado da CIA para Os Perdedores, também adaptação de um quadrinho.

Em 2007, faz parte da equipe Sunshine - Alerta Solar de Danny Boyle, engajado em uma expedição para reviver o sol. Não cansando de ficar longe de Scarlett Johansson, ambos atuam em O Diário de uma Babá. 

Com Capitão América (2011), ele tomou a decisão de sua carreira e assinou um contrato de seis filmes com a Marvel Studios. Ao aceitar o papel de Steve Rogers. Depois de Capitão América, o longa que apresenta o herói ao público , o personagem que ele encarna se junta aos Vingadores, fazendo no total 7 filmes para o MCU e algumas participações especiais em filmes como Thor: O Mundo Sombrio. No entanto, ele não se esquece de sair de seu traje de vez em quando com filmes como O Expresso do Amanhã, O Homem de Gelo, Before We Go, Um Laço de Amor e o sucesso Entre Facas e Segredos. 

Após se aposentar do super-soldado da Marvel, Evans vai para outras produções como Não Olhe Para Cima, Missão no Mar Vermelho e substitui a voz original de Buzz Lightyear, Tim Allen, no novo filme do personagem, Lightyear. Evans ainda assina outro contrato com a Netflix para atuar, ao lado de Ryan Gosling, no filme Agente Oculto.',
                        'https://br.web.img3.acsta.net/c_310_420/pictures/19/04/22/19/59/2129500.jpg',
                        null,
                        1
						);
                        
                        
update tbl_ator set nome_artistico = 'ROBERT DOWNEY JR.' where id = 10;                     
                        
select * from tbl_ator;

###### TABELA : FILME_ATOR #########

#o poderoso chefão
insert into tbl_filme_ator (id_filme, id_ator) values(1, 1), (1, 2);

#Forrest gump
insert into tbl_filme_ator (id_filme, id_ator) values(2, 3), (2, 4);

#o rei leão
insert into tbl_filme_ator (id_filme, id_ator) values(3, 5), (3, 6);

#a espera de um milagre
insert into tbl_filme_ator (id_filme, id_ator) values(4, 3), (4, 7);

#batman
insert into tbl_filme_ator (id_filme, id_ator) values(5, 8), (5, 9);

#vingadores
insert into tbl_filme_ator (id_filme, id_ator) values(6, 10), (6, 11);

select * from tbl_filme_ator;

####### TABELA : DIRETOR #########

insert into tbl_diretor(
							nome,
                            nome_artistico,
                            data_nascimento,
                            biografia,
                            foto,
                            data_falecimento,
                            id_sexo
						)values(
                        'FRANCIS FORD COPPOLA',
                        'Francis F. Coppola',
                        '1939-04-07',
                        '- Em 1969, fundou juntamente com George Lucas a produtora American Zoetrope, em São Francisco, tendo como primeiro projeto o filme THX 1138 (1970);- É tio do ator Nicolas Cage;- Pai da tambem diretora Sofia Coppola;- Foi assistente de direção de Roger Corman;- Graduado na Universidade da Califórnia (UCLA), a mesma dos diretores, George Lucas e Steven Spielberg.',
                        'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/35/21/99/19187501.jpg',
                        null,
                        1
                        );


insert into tbl_diretor(
							nome,
                            nome_artistico,
                            data_nascimento,
                            biografia,
                            foto,
                            data_falecimento,
                            id_sexo
						)values(
                        'Eric R. Roth',
                        'ERIC ROTH',
                        '1945-03-22',
                        'Roth ganhou o Oscar de Melhor Roteiro Adaptado por Forrest Gump . Ele é conhecido por escrever seus scripts em um programa DOS sem acesso à Internet, além de distribuir os scripts apenas em formatos de cópia impressa.Ele seguiu sua vitória no Oscar co-escrevendo roteiros para vários filmes indicados ao Oscar, incluindo The Insider , Munich , The Curious Case of Benjamin Button e A Star Is Born . Enquanto escrevia O Curioso Caso de Benjamin Button , ele perdeu os pais e, como resultado, vê o filme como "... meu filme mais pessoal".',
                        'https://deadline.com/wp-content/uploads/2019/02/rexfeatures_10080896hi.jpg',
                        null,
                        1
                        );



insert into tbl_diretor(
							nome,
                            nome_artistico,
                            data_nascimento,
                            biografia,
                            foto,
                            data_falecimento,
                            id_sexo
						)values(
                        'Christopher Edward Nolan',
                        'CHRISTOPHER NOLAN',
                        '1970-07-30',
                        'Com apenas sete anos de idade, Christopher Nolan já se arriscava por trás das câmeras. Utilizando-se da câmera Super 8 do pai, ele realizou vários pequenos filmes estrelados por seus brinquedos. A vontade de dirigir não passou e ele acabou se tornando um importante realizador.

Formou-se em literatura na Universidade de Londres, na mesma época em que começou a realizar filmes em 16mm. Seu curta "Larceny" foi exibido no Festival de Cinema de Cambridge em 1996.

Nolan estreou na direção com Following (1998), mas foi Amnésia (2000) que chamou a atenção da grande público, abrindo seu caminho para o sucesso em Hollywood. Na sequência, comandou Al Pacino, Robin Williams e Hilary Swank em Insônia (2002).

Em 2005, dirigiu o filme que mudou para sempre sua história: Batman Begins. Ele investiu em um Homem-Morcego mais sombrio e realista, o que ficou ainda mais claro na continuação, Batman - O Cavaleiro das Trevas. O segundo longa rendeu um Oscar póstumo para Heath Ledger, que brilhou na pele do vilão Coringa. Com O Cavaleiro das Trevas Ressurge, fecha sua trilogia sobre o herói.

Em um período "entre-Batmans" realizou A Origem e chamou a atenção pela criatividade e pela complexidade narrativa. O filme arrecadou mais de US$ 800 milhões em todo mundo e conquistou estatuetas no Oscar.
',
                        'https://br.web.img3.acsta.net/c_310_420/pictures/15/02/26/15/33/118611.jpg',
                        null,
                        1
                        );



insert into tbl_diretor(
							nome,
                            nome_artistico,
                            data_nascimento,
                            biografia,
                            foto,
                            data_falecimento,
                            id_sexo
						)values(
                        'Roger Allers',
                        null,
                        '1949-06-29',
                        'Nascido em Rye, Nova York, mas criado em Scottsdale, Arizona, Allers se tornou um fã de animação aos cinco anos de idade, depois de ver Peter Pan da Disney. Decidir o que ele queria buscar uma carreira na Disney e até mesmo trabalhar ao lado de Walt Disney, alguns anos mais tarde, ele foi enviado para a Disneylândia para um  kit de animação. No entanto, Allers, até então um estudante do ensino médio, cresceu desanimado sobre a realização de seu sonho quando ele soube da morte de Walt Disney, em 1966. 
Apesar de não ter a oportunidade de conhecer Walt, Allers ainda conseguiu uma graduação em Artes pela Universidade do Estado do Arizona. Mas quando ele se matriculou em uma aula na Universidade de Harvard, percebeu que seu interesse em animação foi revitalizado. Depois de receber seu diploma em Artes plásticas, ele passou os próximos dois anos viajando e vivendo na Grécia. Enquanto estava lá, ele passou algum tempo vivendo em uma caverna, e, eventualmente, encontrou Leslee, quem mais tarde se casou. Allers aceitou um emprego na Flynn Studios, onde ele trabalhou como animador de projetos como A Rua Sésamo, The Electric Company, Make a Wish, e vários outros comerciais.
Em 1978, ele se mudou para Los Angeles com Steven Flynn para trabalhar em um filme intitulado Animalympics , que ele escreveu a história, design de personagens e animação para o filme. Três anos mais tarde, Allers serviu como membro da equipe de storyboard de Tron, que foi o primeiro filme do qual ele trabalhou. Em 1980, Allers e sua família mudou-se para Toronto, Canadá, onde trabalhou por Nelvana Estúdios como animador em um recurso intitulado Rock & Rule. Após um breve retorno a Los Angeles, Allers fez desde design de personagens, animação preliminar e desenvolvimento da história para animação japonesa, Little Nemo: Adventures in Slumberland. Nos próximos dois anos, ele residiu em Tóquio para servir como um diretor de animação e supervisionar os artistas japoneses. 
Voltando para Los Angeles em 1985, ele soube que a Disney estava procurando por um artista de storyboard para trabalhar em Oliver & Company. Quando ele se candidatou para o trabalho, Allers foi convidado a desenhar alguns exemplos como experiência, e trabalhou em portfólio e foi contratado logo em seguida.[1] Desde então, ele atuou como um artista de storyboard em A Pequena Sereia, The Prince and the Pauper, e The Rescuers Down Under antes que ele foi nomeado Chefe de História em Beauty and the Beast. Quando seu trabalho em Beauty foi concluído, Allers tornou-se artista de storyboard durante a re-escrita de Aladdin. 
Em outubro de 1991, Allers assinou um contrato para co-dirigir King of the Jungle, ao lado de  George Scribner. Allers trouxe a bordo Brenda Chapman, que viria a ser a chefe de história. Depois, vários dos principais membros da equipe, incluindo Allers, Scribner, Don Hahn, Chapman, e a produção do designer Chris Sanders, fizeram uma viagem para o Parque Nacional Hells Gate no Quênia, a fim de estudar e obter uma valorização do ambiente para o filme. Depois de seis meses trabalhando no desenvolvimento da história, Scribner decidiu deixar o projeto, depois dele ter brigado com Allers e os produtores por causa da sua decisão de transformar o filme em um musical, Scribners tinha a intenção de fazer um filme mais documentário focado em aspectos naturais. Após a saída de Scribner e insatisfeito com a história original, Allers, juntamente com Hahn, Sanders, Chapman, e os diretores Kirk Wise e Gary Trousdale ,conceberam uma nova história de destaque para o cinema, ao longo de dois dias, em fevereiro de 1992. Em abril de 1992, Rob Minkoff , foi atribuído como co-diretor, e o título foi alterado para O Rei Leão.
Após o lançamento de O Rei Leão, Allers e o roteirista Mateus Jacobs concebeu a ideia do Kingdom of the Sun, e o desenvolvimento do projeto foi encaminhado em 1994. Enquanto isso, Disney Theatrical Group tinha começado a produção musical da Broadway de O Rei Leão, tal como haviam feito com A bela e a Fera. Primeiramente cético, Allers juntou-se a equipe da produção da Broadway e, juntamente com o co-roteiristas de Rei Leão, Irene Mecchi, escreveu o libreto para o qual ambos foram nomeados ao Prêmio Tony de Melhor Libreto de um Musical. Depois de quase quatro anos no Reino do Sol, Allers pediu para deixar o projeto devido a diferenças criativas com o co-diretor Mark Dindal, exibições testes mal-recebidas, e a falha em cumprir seus prazos promocionais. Em última análise, o projeto foi reformulado em The Emperors New Groove, e Allers começou a trabalhar em Lilo & Stitch, como um supervisor adicional da história. Em 2001, ele foi abordado por Hahn para dirigir o curta-metragem, The Little Matchgirl. O projecto durou quatro anos de trabalho, e apareceu com um bônus em A Pequena Sereia Platinum Edition DVD. 
Enquanto isso, Allers apresentou o conto-balada de folk céltico Tam Lin para Michael Eisner, que na época estava em uma luta corporativa com Roy E. Disney. Uma vez que ele reconheceu o projeto como "bebê" de Disney, ele se recusou a luz verde ao projeto. Em maio de 2003, foi anunciado que Allers e Brenda Chapman dirigir Tam Lin para a Sony Pictures Animation. No entanto, um ano mais tarde, Allers foi recrutado para servir como diretor na Open Season juntamente com o diretor Jill Culton e co-diretor Anthony Stacchi, com os talentos vocais de Martin Lawrence e Ashton Kutcher. 
Em janeiro de 2012, foi anunciado que Allers irá supervisionar a estrutura narrativa, bem como supervisionar a produção de uma adaptação animada de O Profeta. Em Maio de 2014, uma versão não-finalizada de O Profeta, foi exibida no Festival de Cinema de Cannes, e recebeu um lançamento limitado em agosto de 2015. ',
                        'https://br.web.img3.acsta.net/C_310_420/MEDIAS/NMEDIA/18/91/54/06/20150846.JPG',
                        null,
                        1
                        );


insert into tbl_diretor(
							nome,
                            nome_artistico,
                            data_nascimento,
                            biografia,
                            foto,
                            data_falecimento,
                            id_sexo
						)values(
                        'Ferenc Árpád Darabont',
                        'FRANK DARABONT',
                        '1959-01-28',
                        '- É o autor dos roteiros de "A Hora do Pesadelo 3", "A Mosca 2" e "Frankenstein de Mary Shelley".- Trabalhou como roteirista na série de TV norte-americana "O Jovem Indiana Jones".',
                        'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/90/95/95/20122149.jpg',
                        null,
                        1
                        );
                        
                        
                        
insert into tbl_diretor(
							nome,
                            nome_artistico,
                            data_nascimento,
                            biografia,
                            foto,
                            data_falecimento,
                            id_sexo
						)values(
                        'Joseph Vincent Russo',
                        'JOE RUSSO',
                        '1971-07-08',
                        'Joseph Vincent Russo nasceu na cidade de Cleveland, nos EUA. Começou sua carreira como diretor de videoclipes, sempre ao lado do irmão Anthony Russo. Ambos se graduaram em cinema na Universidade de Iowa. Ao lado de Anthony, estreou como realizador de longas em L.A.X. 2194 (1994), telefilme da NBC.Começaram a se destacar a partir da série Arrested Development, que comandaram entre 2003 e 2005, pela qual foram premiados com o Emmy. Entretanto, a fama mundial dos irmãos chegou após ingressarem no Universo Cinematográfico da Marvel, em que dirigiram o blockbuster Capitão América 2: O Soldado Invernal (2014).',
                        'https://br.web.img2.acsta.net/c_310_420/pictures/15/11/24/17/01/231901.jpg',
                        null,
                        1
                        );                        

delete from tbl_diretor where id = 2;

insert into tbl_diretor(
							nome,
                            nome_artistico,
                            data_nascimento,
                            biografia,
                            foto,
                            data_falecimento,
                            id_sexo
						)values(
                        'Robert Lee Zemeckis',
                        'ROBERT ZEMECKIS',
                        '1952-05-14',
                        '- Especialista em efeitos especiais, Robert Zemeckis é um dos partidários dos filmes do também diretor Steven Spielberg, que já produziu vários de seus filmes;

- Trabalhando geralmente com seu parceiro de roteiros Bob Gale, os primeiros filmes de Robert apresentou ao público seu talento para comédias tipo pastelão, como Tudo por uma Esmeralda (1984); 1941 - Uma Guerra Muito Louca (1979) e, acrescentando efeitos muito especiais em Uma Cilada para Roger Rabbit (1988) e De Volta para o Futuro (1985);

- Apesar destes filmes terem sidos feitos meramente para o puro entretenimento, com raros desenvolvimentos dos personagens ou mesmo com uma trama cuidadosa, eles são diversão na certa;

- Seus filmes posteriores no entanto, se tornaram mais sérios e reflexivos, como o enormemente bem sucedido filme estrelado por Tom Hanks Forrest Gump (1994) e o filme estrelado por Jodie Foster Contato (1997), ambos aclamados pela crítica e novamente reunindo atordoantes efeitos especiais;

- Em 2000 o diretor retorna ao trabalho com mais dois filmes: Revelação, com Michelle Pfeiffer e Harrison Ford, e Náufrago, em que retoma a parceria com Tom Hanks;

- Com isso, ao longo de sua carreira Robert tem provado que pode trabalhar em uma trama séria cercada de efeitos especiais, façanha esta que muitos diretores não conseguem realizar, e também conquistar crítica e público alternando os mais variados estilos de filmes;

- Seus filmes quase sempre são produzidos por Steven Spielberg;

- Tem Bob Gale como companheiro de escrita nos roteiros;

- Adora fazer citações a cenas famosas de outros filmes;

- É formado na Escola de Cinema da Universidade de Southern California.',
                        'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/87/57/81/20030814.jpg',
                        null,
                        1
                        );       


select * from tbl_diretor; 


############ TABELA FILME_DIRETOR ##########

#o poderoso chefão
insert into tbl_filme_diretor (id_filme, id_diretor) values(1, 1);

#forrest gump
insert into tbl_filme_diretor (id_filme, id_diretor) values(2, 7);

#o rei leão
insert into tbl_filme_diretor (id_filme, id_diretor) values(3, 4);

#a espera de um milagre
insert into tbl_filme_diretor (id_filme, id_diretor) values(4, 5);  

#batman
insert into tbl_filme_diretor (id_filme, id_diretor) values(5, 3);

#vingadores
insert into tbl_filme_diretor (id_filme, id_diretor) values(6, 6);

select * from tbl_filme_diretor;


###### TABELA FILME_AVALIACAO #######

insert into tbl_filme_avaliacao(
								nota,
                                comentario,
                                id_filme
								)values(
                                3.5,
                                'Um realista e chocante retrato de como a máfia agia nos anos 40. Uma obra-prima de valor incalculável. Marlon Brando em uma perfeita atuação , deixando um marco no cinema como um dos personagens mais respeitados e aclamados pelo público e pela crítica .

'' Farei uma oferta irrecusável a ele ''',
                                1
                                );

insert into tbl_filme_avaliacao(
								nota,
                                comentario,
                                id_filme
								)values(
                                5.0,
                                'Woooollllll, um drama épico!!! Tom Hanks merecia o OSCAR de todos os tempos.... Forrest Gump é o filme! Mesmo sendo longo é incansável! Tenho orgulho de dizer que sou fã desse ator sensacional e desse filme brilhante! Um clássico cinematográfico! :)',
                                2
                                );                                


insert into tbl_filme_avaliacao(
								nota,
                                comentario,
                                id_filme
								)values(
                                5.0,
                                'O MELHOR FILME DA DISNEY DE TODOS OS TEMPOS. Esse filme é muito bom. As músicas são lindas, a história do filme é muito legal e é o melhor filme em animação que eu já vi. O Rei Leão vai ficar nas minha lembranças para sempre, com certeza.',
                                3
                                );
                                
                                
insert into tbl_filme_avaliacao(
								nota,
                                comentario,
                                id_filme
								)values(
                                3.5,
                                'Muito emocionante. Quase chorei quando o ratinho morreu. Como de costume, Tom Hanks arrasando e além dele, todas as demais atuações foram boas, destaque é claro para o Michel Clark Duncan.',
                                4
                                );
                                
                                
insert into tbl_filme_avaliacao(
								nota,
                                comentario,
                                id_filme
								)values(
                                5.0,
                                'O melhor filme do Batman pra mim... E nem falo isso por causa do herói e sim por causa do vilão. O Coringa foi um mito!',
                                5
                                );       
                                
                                
insert into tbl_filme_avaliacao(
								nota,
                                comentario,
                                id_filme
								)values(
                                5.0,
                                'Finalmente, uma conclusão é desfecho de tudo que andávamos vendo nos últimos 10 anos de UCM! Esse longa que eh muito mais que filme mostra e da tudo o que você precisava ver. Fantástico.',
                                6
                                );                                       
                                
                                
select * from tbl_filme_avaliacao;                                

####### TABELA DE NACIONALDIADE #########
insert into tbl_nacionalidade(nome)values('Americano'),
										 ('Brasileiro'),
                                         ('Francês'),
                                         ('Britânico'),
                                         ('Australiano');
 
select * from tbl_nacionalidade; 

##### TABELA ATOR_NACIONALDIADE ######

#o poderoso chefão
insert into tbl_ator_nacionalidade (id_ator, id_nacionalidade) values(1, 1);
insert into tbl_ator_nacionalidade (id_ator, id_nacionalidade) values(2, 1);

#forrest gump
insert into tbl_ator_nacionalidade (id_ator, id_nacionalidade) values(3, 1);
insert into tbl_ator_nacionalidade (id_ator, id_nacionalidade) values(4, 1);

#o rei leão
insert into tbl_ator_nacionalidade (id_ator, id_nacionalidade) values(5, 2);
insert into tbl_ator_nacionalidade (id_ator, id_nacionalidade) values(6, 1);

#a espera de um milagre
insert into tbl_ator_nacionalidade (id_ator, id_nacionalidade) values(7, 1);

#batman
insert into tbl_ator_nacionalidade (id_ator, id_nacionalidade) values(8, 1), (8, 4);
insert into tbl_ator_nacionalidade (id_ator, id_nacionalidade) values(9, 5);

#vingadores
insert into tbl_ator_nacionalidade (id_ator, id_nacionalidade) values(10, 1);
insert into tbl_ator_nacionalidade (id_ator, id_nacionalidade) values(11, 1);


select * from tbl_ator_nacionalidade;

######### TABELA DIRETOR_NACIONALIDADE #########

#o poderoso chefão
insert into tbl_diretor_nacionalidade (id_diretor, id_nacionalidade) values(1, 1);

#forrest gump
insert into tbl_diretor_nacionalidade (id_diretor, id_nacionalidade) values(7, 1);

#o rei leão
insert into tbl_diretor_nacionalidade (id_diretor, id_nacionalidade) values(4, 1);

#a espera de um milagre
insert into tbl_diretor_nacionalidade (id_diretor, id_nacionalidade) values(5, 1), (5, 3);

#batman
insert into tbl_diretor_nacionalidade (id_diretor, id_nacionalidade) values(3, 4);

#vingadores
insert into tbl_diretor_nacionalidade (id_diretor, id_nacionalidade) values(6, 1);

select * from tbl_diretor_nacionalidade;


###### SELECTS ########

# ESTRUTURA DO SELECT 
# 		select -  serve para especificar quais colunas serão exibidas
# 		from - serve para definir qual(is) tabelas serão utilizadas
# 		where - serve para definir o critério de busca

#Retorna todas as colunas de uma tabela e todos os registros
select * from tbl_filme;
select tbl_filme.* from tbl_filme;

# Retorna apenas as colunas escolhidas
select id, nome, nome_original from tbl_filme;
select tbl_filme.id, tbl_filme.nome, tbl_filme.nome_original from tbl_filme;

# Ajuste virtual
# Podemos criar nomenclaturas virtuais
# para as colunas e tabelas (isso não altera fisicamente a tabela) 
select tbl_filme.id as id_filme,
	   tbl_filme.nome as nome_filme,
       tbl_filme.nome_original
from tbl_filme;       

select filme.nome as nome_filme,
	   ator.nome as nome_ator
from tbl_filme as filme, tbl_ator as ator;       

# Permite ordenar de forma crescente e descrecente (ela é a ultima coisa que deve ser feita no script)
select * from tbl_filme order by nome;
select * from tbl_filme order by nome asc;
select * from tbl_filme order by nome desc;
select * from tbl_filme order by nome, data_lancamento desc, sinopse asc;

#Limitar a quantidade de registros que serão exibidos (diferente em outros bancos)
select * from tbl_filme limit 2;

#Padronizar os dados deixando tudo para maiuscula (o upper tbm funciona)
select ucase(tbl_filme.nome) as nome from tbl_filme;
select upper(tbl_filme.nome) as nome from tbl_filme;

# Padronizar os dados deixando tudo para minusculo (o lower tbl funciona)
select lcase(tbl_filme.nome) as nome from tbl_filme;
select lower(tbl_filme.nome) as nome from tbl_filme;


# Manda a quantidade de caracteres 
select length(tbl_filme.nome) as quantidade_caracteres from tbl_filme;

#concatenar String com o valor que vai ser mandado
select concat('Filme: ', tbl_filme.nome) as nome_filme_formatado from tbl_filme;

# concat e substr juntos
select concat(substr(tbl_filme.sinopse, 1, 50), '... Leia Mais') as sinopse_reduzida from tbl_filme;

select * from tbl_filme;
desc tbl_filme;

alter table tbl_filme
		add column valor_unitario float;

update tbl_filme set valor_unitario = 43.50 where id = 1;
update tbl_filme set valor_unitario = 37.80 where id = 3;
update tbl_filme set valor_unitario = 50.10 where id = 4;

#Encontra o menor valor 
select min(valor_unitario) as minimo from tbl_filme;

#Encontra o maior valor
select max(valor_unitario) as maximo from tbl_filme;

#Encontra a média dos valores
select avg(valor_unitario) as media from tbl_filme;

#Limita as casas decimais e realiza o arredondamento
select round(avg(valor_unitario), 2) as media_2casas_decimais from tbl_filme;

#Soma de todos os valores
select round(sum(valor_unitario), 2) as total from tbl_filme;

#Realizando calculos matematicos no BANCO DE DADOS
select tbl_filme.nome, tbl_filme.foto_capa, 
	   concat('R$ ' , tbl_filme.valor_unitario) as valor_unitario, 
	   concat('R$ ' , round((tbl_filme.valor_unitario - ((tbl_filme.valor_unitario * 10)/100)), 2)) as valor_desconto	
from tbl_filme;

#OPERADORES DE COMPARAÇÃO
# = 			Igualdade
# <				Menor
# > 			Maior
# <=			Menor ou igual
# >=			Maior ou igual
# <> ou !=		Diferente
# like			
# is			

#OPERADORES LÓGICOS
# and
# or
# not	


# Menor
select tbl_filme.nome, tbl_filme.foto_capa, tbl_filme.valor_unitario
from tbl_filme
where tbl_filme.valor_unitario < 40;

# Menor ou igual
select tbl_filme.nome, tbl_filme.foto_capa, tbl_filme.valor_unitario
from tbl_filme
where tbl_filme.valor_unitario <= 40;

# Maior
select tbl_filme.nome, tbl_filme.foto_capa, tbl_filme.valor_unitario
from tbl_filme
where tbl_filme.valor_unitario > 40;

# Maior ou igual
select tbl_filme.nome, tbl_filme.foto_capa, tbl_filme.valor_unitario
from tbl_filme
where tbl_filme.valor_unitario >= 40;

# Exemplo com o order by
select tbl_filme.nome, tbl_filme.foto_capa, tbl_filme.valor_unitario
from tbl_filme
where tbl_filme.valor_unitario >= 40
order by tbl_filme.valor_unitario desc;

# Diferente
select tbl_filme.nome, tbl_filme.foto_capa, tbl_filme.valor_unitario
from tbl_filme
where tbl_filme.valor_unitario <> 40;

#LIKE
select * from tbl_filme where tbl_filme.nome = 'leão';
select * from tbl_filme where tbl_filme.nome like 'leão'; #Retorna somente a igualdade
select * from tbl_filme where tbl_filme.nome like 'leão%'; #Retorna o que inicia com a palavra chave
select * from tbl_filme where tbl_filme.nome like '%leão'; #Retorna o que termina com a palavra chave
select * from tbl_filme where tbl_filme.nome like '%leão%'; #Retorna por qualquer parte da busca


# Pedindo para retornar os filmes que tem valor unitario e os que o valor unitario são null 
select tbl_filme.nome, tbl_filme.foto_capa, tbl_filme.valor_unitario
from tbl_filme
where tbl_filme.valor_unitario <> 40 or tbl_filme.valor_unitario is null;


# is - verifica se os registro estão nulos
select * from tbl_filme where tbl_filme.valor_unitario is null; 

# is not - verifica se os registros não estão nulos
select * from tbl_filme where tbl_filme.valor_unitario is not null;

# Retorna entre 40 e 50
select * from tbl_filme
where tbl_filme.valor_unitario >= 40 and tbl_filme.valor_unitario <=50;

# between - Retorna os registro com um range de valores
select * from tbl_filme
where tbl_filme.valor_unitario between 40 and 50;

# not betwwn - retorna as estremidades, ou seja, tudo que não for entre 40 e 50
select * from tbl_filme
where tbl_filme.valor_unitario not between 40 and 50;



######### FORMATANDO DATA E HORA ############

# Mostrar a data atual do servidor
select curdate() as data_atual;
select current_date() as data_atual;

# Mostra a hora atual do servidor
select curtime() as hora_atual;
select current_time() as hora_atual;

# Mostra a data e a hora atual
select current_timestamp() as data_hora_atual;

#Formatando a Hora
select time_format( curtime(), '%H') as horario_formatado; #retorna somente a hora (00 a 23)
select time_format( curtime(), '%T') as horario_formatado; #retorna a hora assim como o H
select time_format( curtime(), '%h') as horario_formatado; #Retorna somente a hora (00 a 12)
select time_format( curtime(), '%i') as horario_formatado; #Retorna somente o minuto
select time_format( curtime(), '%s') as horario_formatado; #Retorna somente o segundo
select time_format( curtime(), '%Hh%i') as horario_formatado; #Retorna a hora e a minuto
select time_format( curtime(), '%r') as horario_formatado; #Retorna no padrão(AM / PM)
select time_format( curtime(), '%p') as horario_formatado; #Retorna somente padrão(AM / PM)

# Funções (hour, minute, second)
select hour(curtime()) as hora_formatada; #Retorna só a Hora
select minute(curtime()) as hora_formatada; # retorna só o minuto
select second(curtime()) as hora_formatada; # retorna só o segundo

# Formatando Data
select date_format(curdate(), '%d') as data_formatada; # Retorna o dia 
select date_format(curdate(), '%m') as data_formatada; # Retorna o mês em numeral
select date_format('2020-11-21', '%M') as data_formatada; # Retorna o mês por extenso
select date_format('2020-11-21', '%b') as data_formatada; # Retorna o mês abreviado
select date_format(curdate(), '%y') as data_formatada; # Retorna o ano com 2 digitos
select date_format(curdate(), '%Y') as data_formatada; # Retorna o ano com 4 digitos
select date_format(curdate(), '%w') as data_formatada; # Retorna o numeral do dia da semana
select date_format(curdate(), '%W') as data_formatada; # Retorna o nome do dia da semana


select day(curdate()) as data_formatada; # Retorna somente o dia
select month(curdate()) as data_formatada; # Retorna somente o mês
select year(curdate()) as data_formatada; # Retorna somente o ano
select dayname(curdate()) as data_formatada; # Retorna o dia extenso
select dayofmonth(curdate()) as data_formatada; # Retorna o dia do mês
select dayofyear(curdate()) as data_formatada; # Retorna o dia do ano
select dayofweek(curdate()) as data_formatada; # Retorna o dia em numeral da semana
select monthname(curdate()) as data_formatada; # Retorna nome do mês
select yearweek(curdate()) as data_formatada; # Retorna o ano e a semana
select weekofyear(curdate()) as data_formatada; # Retorna apenas a semana do ano


select date_format(curdate(), '%d/%m/%Y') as data_formatada; # retorna no padrão br
select date_format(str_to_date('05/07/2022', '%d/%m/%Y'), '%Y-%m-%d') as data_universal; # retorna no padrão universal

#Diferença de datas
select datediff('2023-05-24', '2023-05-01') as qtde_dias,
		(datediff('2023-05-24', '2023-05-01')*5) as valor_pagar;

# Difernça de horas        
select timediff('16:15:00', '10:05:10') as qtde_horas,
		hour(timediff('16:15:00', '10:05:10')* 5) as valor_pagar,
        addtime(timediff('16:15:00', '10:05:10'), '01:00:00');
        
# Soma de horas
select addtime('06:00:00', '01:00:00');

select 'senai' as dados,
	   md5('senai') as dados_criptografados_md5,
       sha('senai') as dados_criptografados_sha,
       sha1('senai') as dados_criptografados_sha1,
       sha2('senai', 256) as dados_criptografados_sha2;
       
# RELACIONAMENTO ENTRE TABELAS

## RELACIONAMENTO PELO WHERE

#Exemplo 1
select tbl_ator.nome, tbl_ator.data_nascimento,
	   tbl_sexo.sigla	

from   tbl_ator, tbl_sexo
# é quem especifica a relação entre as duas tabelas
where  tbl_sexo.id = tbl_ator.id_sexo;

#Exemplo 2
select tbl_ator.nome, tbl_ator.foto, tbl_ator.biografia,
	   tbl_sexo.sigla, tbl_sexo.nome,
       tbl_nacionalidade.nome

from   tbl_ator, tbl_sexo, tbl_nacionalidade, tbl_ator_nacionalidade

where tbl_sexo.id = tbl_ator.id_sexo and 
	  tbl_ator.id = tbl_ator_nacionalidade.id_ator and
      tbl_nacionalidade.id = tbl_ator_nacionalidade.id_nacionalidade;
       

## RELACIONAMENTO PELO FROM   

#Exemplo 1
select tbl_ator.nome, tbl_ator.data_nascimento,
       tbl_sexo.sigla
       
from   tbl_ator
			inner join tbl_sexo
				on tbl_sexo.id = tbl_ator.id_sexo;


#Exemplo 2
select tbl_ator.nome as nome_ator, tbl_ator.foto, tbl_ator.biografia,
	   tbl_sexo.sigla, tbl_sexo.nome as nome_sexo,
       tbl_nacionalidade.nome as nome_nacionalidade

from tbl_ator
		inner join tbl_sexo
			on tbl_sexo.id = tbl_ator.id_sexo
        inner join tbl_ator_nacionalidade 
			on tbl_ator.id = tbl_ator_nacionalidade.id_ator
        inner join tbl_nacionalidade
			on tbl_nacionalidade.id = tbl_ator_nacionalidade.id_nacionalidade;


select tbl_filme.nome as nome_filme, tbl_filme.data_lancamento, tbl_filme.sinopse,
	   tbl_genero.nome as nome_genero,
       tbl_ator.nome as nome_ator, tbl_ator.biografia,
       tbl_nacionalidade.nome as ator_nacionalidade,
	   tbl_sexo.nome as sexo_ator

from tbl_filme
		inner join tbl_filme_genero
			on tbl_filme.id = tbl_filme_genero.id_filme
        inner join tbl_genero
			on tbl_genero.id = tbl_filme_genero.id_genero
        inner join tbl_filme_ator
			on tbl_filme.id = tbl_filme_ator.id_filme
        inner join tbl_ator
			on tbl_ator.id = tbl_filme_ator.id_ator
        inner join tbl_ator_nacionalidade
			on tbl_ator.id = tbl_ator_nacionalidade.id_ator
		inner join tbl_nacionalidade
			on tbl_nacionalidade.id = tbl_ator_nacionalidade.id_nacionalidade
		inner join tbl_sexo
			on tbl_sexo.id = tbl_ator.id_sexo   
order by nome_filme, nome_ator asc;
