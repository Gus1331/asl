CREATE DATABASE asl;
DROP DATABASE asl;

USE asl;

CREATE TABLE sensor
	(sensorId INT PRIMARY KEY AUTO_INCREMENT,
    empresaId INT NOT NULL,
    esteira VARCHAR(10),
    tipo VARCHAR(7) NOT NULL);
     
ALTER TABLE sensor MODIFY COLUMN tipo VARCHAR(7), ADD CONSTRAINT checktipo CHECK (tipo = 'entrada' OR tipo = 'saida');

CREATE TABLE registro
	(registroId INT PRIMARY KEY AUTO_INCREMENT,
    sensorId INT,
    dataRegistro DATETIME DEFAULT CURRENT_TIMESTAMP);

CREATE TABLE esteira
	(empresaId INT PRIMARY KEY AUTO_INCREMENT,
    identificacao VARCHAR(10),
	produto VARCHAR(25),
    condicao VARCHAR(10),
    producaoEstimadaPorMin INT);
    
ALTER TABLE esteira MODIFY COLUMN condicao VARCHAR(11), ADD CONSTRAINT checkCondicao CHECK (condicao = 'funcionando' OR condicao = 'parado');

CREATE TABLE cliente
	(clientesId INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    qtdSensores INT DEFAULT NULL,
    email VARCHAR(256) NOT NULL,
    tel VARCHAR(15),
    cnpj INT DEFAULT NULL,
    cpf INT DEFAULT NULL,	
    senha VARCHAR(30) NOT NULL);


-- VALORES -------------------------------------------------

    
    
SELECT * FROM sensor;

SELECT * FROM cliente;

SELECT * FROM esteira;

SELECT * FROM registro;