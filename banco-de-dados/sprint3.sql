 -- BANCO DE DADOS ----------------------------------------------------
CREATE DATABASE asl;
USE asl;

 -- TABELAS -----------------------------------------------------------
 CREATE TABLE empresa /* 4 colunas */
	(idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50),
    cnpj CHAR(14) NOT NULL,
	qtdSensores INT NOT NULL,
    responsavel INT
) AUTO_INCREMENT = 100;

CREATE TABLE usuario /* 8 colunas */
	(idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    fkEmpresa INT,
    email VARCHAR(256) NOT NULL,
    tel CHAR(15),
    cpf CHAR(11) NOT NULL,	
    senha VARCHAR(30) NOT NULL,
    		CONSTRAINT fkEmpresa FOREIGN KEY (fkEmpresa)
				REFERENCES empresa(idEmpresa)
) AUTO_INCREMENT = 1000;
 
 CREATE TABLE esteira /* 5 colunas */
	(idEsteira INT AUTO_INCREMENT,
    fkEmpresa INT,
    PRIMARY KEY (idEsteira, fkEmpresa),
    identificacao VARCHAR(10),
	produto VARCHAR(25),
    condicao VARCHAR(10),
    producaoEstimadaPorMin INT,
		CONSTRAINT fkEmpresaEsteira FOREIGN KEY (fkEmpresa)
				REFERENCES empresa(idEmpresa)
) AUTO_INCREMENT = 10000;
 
CREATE TABLE sensor /* 4 colunas */
	(idSensor INT AUTO_INCREMENT,
    tipo VARCHAR(7) NOT NULL,
    fkEsteira INT,
	PRIMARY KEY (idSensor, fkEsteira),
			CONSTRAINT fkEsteira FOREIGN KEY (fkEsteira)
				REFERENCES esteira(idEsteira)
) AUTO_INCREMENT = 5000;

CREATE TABLE registro /* 3 colunas */
	(idRegistro INT AUTO_INCREMENT,
    fkSensor INT,
    PRIMARY KEY(idRegistro, fkSensor),
    dataRegistro DATETIME DEFAULT CURRENT_TIMESTAMP,
		CONSTRAINT fkSensor FOREIGN KEY (fkSensor)
			REFERENCES sensor(idSensor)
) AUTO_INCREMENT = 10000;
    
-- CONSTRAINTS ------------------------------------------------
ALTER TABLE empresa 
	ADD CONSTRAINT fkUsuarioEmpresa FOREIGN KEY (responsavel)
			REFERENCES usuario(idUsuario);
ALTER TABLE sensor MODIFY COLUMN tipo VARCHAR(7), ADD CONSTRAINT checktipo CHECK (tipo = 'entrada' OR tipo = 'saida');
ALTER TABLE esteira MODIFY COLUMN condicao VARCHAR(11), ADD CONSTRAINT checkCondicao CHECK (condicao = 'funcionando' OR condicao = 'parado');

-- INSERTS -----------------------------------------------------

INSERT INTO empresa (nome, cnpj, qtdSensores) VALUES
('Action Sensor Lux', '11111111111111', '100');
    
-- SELECTS -----------------------------------------------------
SELECT * FROM usuario;
SELECT * FROM sensor;
SELECT * FROM esteira;
SELECT * FROM registro;
SELECT * FROM empresa;

-- Empresa e Responsável
SELECT empresa.nome AS 'Empresa', usuario.nome AS 'Responsavel' , usuario.tel AS 'Contato'
	FROM empresa JOIN usuario ON responsavel = idUsuario;

-- Empresa e seus funcionários
SELECT e.nome AS 'Empresa',
	u.nome AS 'Funcionário', 
    u.email AS 'Email',
    u.cpf AS 'CPF'
    FROM empresa e JOIN usuario u ON fkEmpresa = idEmpresa;

-- Esteira, seus sensores e registros
SELECT esteira.identificacao AS 'Esteira', 
	sensor.idSensor AS 'Sensor', 
    sensor.tipo AS 'Tipo',
	registro.idRegistro AS 'Registro' ,
    registro.dataRegistro AS 'Data do registro'
    FROM esteira JOIN sensor ON idEsteira = fkEsteira 
    JOIN registro ON idSensor = fkSensor;
