create database Exercicio11;

use exercicio11;

create table Departamento(
idDepto int primary key,
nomeDepto varchar(45),
fkGerente int,
dataInicioGer date);

create table funcionario(
idFunc int primary key,
nomeFunc varchar(30),
salario decimal (10,2),
sexo varchar(45),
fkSupervisor int,
dataNasc date,
fkDepto int);

create table projeto(
idproj int primary key,
nomeProj varchar(45),
localProj varchar(45),
fkDepto int
);

create table FuncProj(
fkFunc int,
fkProj int,
horas decimal(3,1),
primary key (fkFunc, fkProj)
);

insert into funcionario values
(1,'Joao Silva', 3500, 'm', '2', '1985-01-09', '105'),
(2,'Fernando Wong', 4500, 'm', '8', '1975-12-08', '105'),
(3,'Alice Sousa', 2500, 'f', '7', '1988-01-19', '104'),
(4,'Janice Morais', 4300, 'f', '8', '1970-06-20', '104'),
(5,'Ronaldo Lima', 3800, 'm', '1', '1982-09-15', '105'),
(6,'Joice Leite', 2500, 'f', '1', '1992-07-31', '105'),
(7,'Antonio Pereira', 2500, 'm', '4', '1989-03-29', '104'),
(8,'Juliano Brito', 5500, 'm', null, '1957-11-10', '101');

insert into departamento values
(105, 'Pesquisa', 2, '2008-05-22'),
(104, 'Administração', 7, '2015-01-01'),
(101, 'Matriz', 8, '2001-06-19');

insert into projeto values
(1, 'Produto x', 'Santo André', 105),
(2, 'Produto y', 'Itu', 105),
(3, 'Produto z', 'São Paulo', 105),
(10, 'Informatização', 'Mauá', 104),
(20, 'Reorganização', 'São Paulo', 101),
(30, 'Beneficios', 'Mauá', 104);

insert into funcproj values
(1, 1, 32.5),
(1, 2, 7.5),
(5, 3, 40.0),
(6, 1, 20.0),
(6, 2, 20.0),
(2, 2, 10.0),
(2, 3, 10.0),
(2, 10, 10.0),
(2, 20, 10.0),
(3, 30, 30.0),
(3, 10, 10.0),
(7, 10, 35.0),
(7, 30, 5.0),
(4, 30, 20.0),
(4, 20, 15.0),
(8, 20, null);

alter table departamento add constraint fkGer foreign key (fkGerente) references funcionario(idFunc);

alter table funcionario add constraint fkSup foreign key (fkSupervisor) references funcionario(idFunc);

alter table projeto add constraint fkDept foreign key (fkDepto) references departamento(idDepto);

alter table funcproj add constraint fkfunci foreign key (fkFunc) references funcionario(idFunc);

alter table funcproj add constraint fkprojeto foreign key (fkproj) references projeto(idproj);

select * from funcionario;

select * from departamento;

select * from projeto;

select * from funcproj;


-- impossível adicionar sem o id (chave primaria), erro 1048
insert into funcionario values
(null, 'Cecília Ribeiro', 2800, 'f', null, '1980-04-05', 104);


-- id e nome ja existem na tabela, impossível adicionar. (o certo seria utilizar o update se quisesse mudar o salario e o supervisor) erro 1062
insert into funcionario values
(3, 'Alice Sousa', '2800', 'f', 4, '1980-04-05', 104);

-- agora foi possível adicionar pois o id foi declarado e não é repetido
insert into funcionario values
(9, 'Cecília Ribeiro', 2800, 'f', null, '1980-04-05', 107);

-- impossivel adicionar, campos repetidos, erro 1062
insert into funcionario values
(9, 'Cecília Ribeiro', 2800, 'f', 4, '1980-04-05', 104);


-- foi possível, mas o feito teve consequências na integridade dos dados, pois agora há campos com os dados errados
delete from funcproj where fkfunc = 3 and fkproj = 10;


-- não é possível excluir uma tupla onde o id é referenciado por outra tabela como foreign key, (erro 1451 violação de constraint)
delete from funcionario where idfunc = 4;


-- não é possível excluir uma tupla onde o id é referenciado por outra tabela como foreign key, (erro 1451 violação de constraint)
delete from funcionario where idfunc = 2;


-- foi possível alterar, pois o campo salário não tem ligação via foreign key com nenhuma outra entidade
update funcionario set salario = 2800 where idFunc = 3;

-- foi possível alterar, pois a fkdepto 101 existe na tabela relacionada via foreign key
update funcionario set fkDepto = 101 where idFunc = 3;

-- foi possível alterar, pois a fkdepto 107 existe na tabela relacionada via foreign key
update funcionario set fkDepto = 107 where idFunc = 3;


select dataNasc, salario from funcionario where nomeFunc = 'João Silva';

select salario from funcionario;

select distinct(salario) from funcionario;

select * from funcionario order by nomeFunc;

select * from funcionario order by salario desc;

select * from funcionario where salario between 2000 and 4000;

select * from funcionario where nomefunc like 'j%';

select * from funcionario where nomefunc like '%a';

select * from funcionario where nomefunc like '__n%';

select nomefunc, datanasc from funcionario where nomefunc like '%s____';

select * from funcionario where fkDepto = 105;

select * from funcionario where fkDepto = 105 and salario > 3500;

select * from funcionario where fkDepto = 105 and nomefunc like 'j%';

select func.idfunc as idFuncionario,
	func.nomefunc as NomeFuncionario,
	sup.idfunc as idSupervisor,
	sup.nomefunc as nomeSupervisor
	From funcionario as func
	join funcionario as sup
    on func.fkSupervisor = sup.idfunc; 
    
select p.idproj, p.fkDepto, f.nomeFunc, f.datanasc
	from projeto as p join departamento as d
	on p.fkDepto = d.idDepto
	join funcionario as f on f.idfunc = d.fkGerente 
	where p.fkDepto in (105, 101);
    
select idfunc, nomeFunc, fkproj, nomeproj, horas
	from funcionario join funcproj
    on idfunc= fkfunc
    join projeto on
    idproj = fkproj;
    
    select nomefunc from funcionario where datanasc < '1980-01-01';
    
    select count(salario) from funcionario;
    
    select count(distinct(localproj)) from projeto;
    
    select avg(salario), sum(salario) from funcionario;
    
    select min(salario), max(salario) from funcionario;
    
    select d.idDepto, avg(salario), sum(salario) from departamento as d
  right join funcionario as f on idFunc = fkGerente 
    group by idDepto;
    
    
    select d.idDepto, min(salario) from departamento as d
  right join funcionario as f on idFunc = fkGerente 
    group by idDepto;
    
    insert into funcionario values
    (10, 'José da Silva', 1800, 'm', 3, '2000-10-12', null),
    (11, 'Benedito Almeida', 1200, 'm', 5, '2001-09-01', null);
    
    insert into departamento values
    (110, 'RH', 3, '2018-11-10');