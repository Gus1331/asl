 -- BANCO DE DADOS ----------------------------------------------------
CREATE DATABASE asl;
USE asl;

 -- TABELAS -----------------------------------------------------------
 CREATE TABLE empresa /* 4 colunas */
	(idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50),
    cnpj CHAR(14),
	qtdSensores INT NOT NULL,
    responsavel INT
);

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
);
 
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
);
 
CREATE TABLE sensor /* 4 colunas */
	(idSensor INT AUTO_INCREMENT,
    tipo VARCHAR(7) NOT NULL,
    fkEsteira INT,
	PRIMARY KEY (idSensor, fkEsteira),
			CONSTRAINT fkEsteira FOREIGN KEY (fkEsteira)
				REFERENCES esteira(idEsteira)
);

CREATE TABLE registro /* 3 colunas */
	(idRegistro INT AUTO_INCREMENT,
    fkSensor INT,
    PRIMARY KEY(idRegistro, fkSensor),
    dataRegistro DATETIME DEFAULT CURRENT_TIMESTAMP,
		CONSTRAINT fkSensor FOREIGN KEY (fkSensor)
			REFERENCES sensor(idSensor)
);
    
-- CONSTRAINTS ------------------------------------------------
ALTER TABLE empresa 
	ADD CONSTRAINT fkUsuarioEmpresa FOREIGN KEY (responsavel)
			REFERENCES usuario(idUsuario);	
ALTER TABLE sensor MODIFY COLUMN tipo VARCHAR(7), ADD CONSTRAINT checktipo CHECK (tipo = 'entrada' OR tipo = 'saida');
ALTER TABLE esteira MODIFY COLUMN condicao VARCHAR(11), ADD CONSTRAINT checkCondicao CHECK (condicao = 'funcionando' OR condicao = 'parado');

-- VALORES -----------------------------------------------------

INSERT INTO usuario VALUES
	(790, 'Cleber Antônio Araujo', NULL, 'cleber@email.com', '123456789-00', 12345667, 'senha123'),
	(402, 'Ana Beatriz das Flores', NULL, 'ana@email.com', '345678912-00', 38738472, '62#Fot5R'),
	(791, 'Joao Freitas', NULL, 'joao@gmail.com', '84193728900', 49841589, 'ult6779gf');
    
INSERT INTO empresa VALUES 
    (409, 'Action Sensor Lux', '12345678912345', 202, 790),
    (551, 'Sebrae', '12345678912345', 458, 402);
    
INSERT INTO esteira VALUES
	(269, 409, '1', 'copo modelo J', 'funcionando', 40),
    (270, 409, '2', 'copo modelo K', 'parado', 45),
    (856, 551, 'Forno C', 'frasco 4', 'funcionando',55);
    
INSERT INTO sensor VALUES 
	(126, 'entrada', 269),
    (127, 'saida', 270),
    (723, 'entrada', 856);

INSERT INTO registro (idRegistro, fkSensor) VALUES
	(1298312, 126),
    (1298313, 127),
    (1298314, 723);
    
-- SELECTS -----------------------------------------------------
SELECT * FROM usuario;
SELECT * FROM sensor;
SELECT * FROM esteira;
SELECT * FROM registro;
SELECT * FROM empresa;

SELECT empresa.nome AS 'Empresa', usuario.nome AS 'Responsavel' FROM empresa JOIN usuario ON responsavel = idUsuario;
SELECT esteira.identificacao AS 'Esteira', sensor.idSensor AS 'Sensor', registro.idRegistro AS 'Registro' FROM esteira JOIN sensor ON idEsteira = fkEsteira JOIN registro ON idSensor = fkSensor;