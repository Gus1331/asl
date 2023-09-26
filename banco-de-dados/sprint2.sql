 -- BANCO DE DADOS ----------------------------------------------------
CREATE DATABASE asl;
USE asl;


 -- TABELAS -----------------------------------------------------------
CREATE TABLE cliente /* 8 colunas */
	(clientesId INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    fkEmpresa INT,
    email VARCHAR(256) NOT NULL,
    tel CHAR(15),
    cpf CHAR(11) NOT NULL,	
    senha VARCHAR(30) NOT NULL,
    		CONSTRAINT fkEmpresa FOREIGN KEY (fkEmpresa)
				REFERENCES empresa(empresaId));
    
CREATE TABLE empresa /* 4 colunas */
	(empresaId INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50),
    cnpj CHAR(14),
	qtdSensores INT NOT NULL,
    responsavel VARCHAR(50)
);
 
CREATE TABLE sensor /* 4 colunas */
	(sensorId INT PRIMARY KEY AUTO_INCREMENT,
    empresaId INT NOT NULL,
    tipo VARCHAR(7) NOT NULL,
    fkEsteira INT,
			CONSTRAINT fkEsteira FOREIGN KEY (fkEsteira)
				REFERENCES esteira(esteiraId));
    
CREATE TABLE esteira /* 5 colunas */
	(esteiraId INT PRIMARY KEY AUTO_INCREMENT,
    fkEmpresa INT,
    identificacao VARCHAR(10),
	produto VARCHAR(25),
    condicao VARCHAR(10),
    producaoEstimadaPorMin INT,
		CONSTRAINT fkEmpresaEsteira FOREIGN KEY (fkEmpresa)
				REFERENCES empresa(empresaId));

CREATE TABLE registro /* 3 colunas */
	(registroId INT PRIMARY KEY AUTO_INCREMENT,
    fkSensor INT,
    dataRegistro DATETIME DEFAULT CURRENT_TIMESTAMP,
		CONSTRAINT fkSensor FOREIGN KEY (fkSensor)
			REFERENCES sensor(sensorId));
    
-- CONSTRAINTS ------------------------------------------------
ALTER TABLE sensor MODIFY COLUMN tipo VARCHAR(7), ADD CONSTRAINT checktipo CHECK (tipo = 'entrada' OR tipo = 'saida');
ALTER TABLE esteira MODIFY COLUMN condicao VARCHAR(11), ADD CONSTRAINT checkCondicao CHECK (condicao = 'funcionando' OR condicao = 'parado');

-- VALORES -----------------------------------------------------

INSERT INTO cliente VALUES
	(790, 'Cleber Antônio Araujo', 16, 'cleber@email.com', '123456789-00', 12345667, NULL, 'senha123'),
	(402, 'Ana Beatriz das Flores', 36, 'ana@email.com', '345678912-00', NULL, 38738472, '62#Fot5R'),
	(791, 'Joao Freitas', 18, 'joao@gmail.com', '84193728900', NULL, 49841589, 'ult6779gf');
    
INSERT INTO sensor VALUES 
	(126, 268, '1', 'entrada'),
    (127, 269, '1', 'saida'),
    (723, 856, 'Forno C', 'entrada');
    
INSERT INTO esteira VALUES
	(269, '1', 'copo modelo J', 'funcionando', 40),
    (270, '2', 'copo modelo K', 'parado', 45),
    (856, 'Forno C', 'frasco 4', 'funcionando',55);

INSERT INTO registro (registroId, sensorId) VALUES
	(1298312, 126),
    (1298313, 126),
    (1298314, 723);
    
-- SELECTS -----------------------------------------------------
SELECT * FROM cliente;

SELECT * FROM sensor;

SELECT * FROM esteira;

SELECT * FROM registro;

SELECT * FROM empresa;






















TRUNCATE TABLE cliente;
TRUNCATE TABLE registro;
TRUNCATE TABLE sensor;
TRUNCATE TABLE esteira;
DROP DATABASE asl;