var database = require("../database/config");

function buscarUltimasMedidas() {

    instrucaoSql = ''

    instrucaoSql = `SELECT (SELECT COUNT(*) FROM registro JOIN sensor ON fkSensor = idSensor WHERE sensor.tipo = 'Saida') AS saida,
    (SELECT COUNT(*) FROM registro JOIN sensor ON fkSensor = idSensor WHERE sensor.tipo = 'Entrada') AS entrada;`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarMedidasEmTempoReal(idAquario) {

    instrucaoSql = ''

    if (process.env.AMBIENTE_PROCESSO == "producao") {
        instrucaoSql = `select top 1
        dht11_temperatura as temperatura, 
        dht11_umidade as umidade,  
                        CONVERT(varchar, momento, 108) as momento_grafico, 
                        fk_aquario 
                        from medida where fk_aquario = ${idAquario} 
                    order by id desc`;

    } else if (process.env.AMBIENTE_PROCESSO == "desenvolvimento") {
        instrucaoSql = `select 
        dht11_temperatura as temperatura, 
        dht11_umidade as umidade,
                        DATE_FORMAT(momento,'%H:%i:%s') as momento_grafico, 
                        fk_aquario 
                        from medida where fk_aquario = ${idAquario} 
                    order by id desc limit 1`;
    } else {
        console.log("\nO AMBIENTE (produção OU desenvolvimento) NÃO FOI DEFINIDO EM app.js\n");
        return
    }

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarDadosDiario() {

    instrucaoSql = ''

    instrucaoSql = `SELECT (SELECT COUNT(*) FROM registro JOIN sensor ON fkSensor = idSensor 
    JOIN esteira ON fkEsteira = idEsteira
    WHERE esteira.produto = 'Garrafa' AND registro.dataRegistro >= NOW() - INTERVAL 1 DAY) AS garrafa,
    (SELECT COUNT(*) FROM registro JOIN sensor ON fkSensor = idSensor 
    JOIN esteira ON fkEsteira = idEsteira
    WHERE esteira.produto = 'copo' AND registro.dataRegistro >= NOW() - INTERVAL 1 DAY) AS copo,
    (SELECT COUNT(*) FROM registro JOIN sensor ON fkSensor = idSensor 
    JOIN esteira ON fkEsteira = idEsteira
    WHERE esteira.produto = 'Frasco' AND registro.dataRegistro >= NOW() - INTERVAL 1 DAY) AS frasco,
    (SELECT DATE_FORMAT(NOW(), "%d/%m")) AS dia`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    buscarUltimasMedidas,
    buscarMedidasEmTempoReal,
    buscarDadosDiario,
}
