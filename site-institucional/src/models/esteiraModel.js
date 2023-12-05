var database = require("../database/config");

function buscarEsteirasPorEmpresa(empresaId) {

  instrucaoSql = `SELECT * FROM esteira WHERE fkEmpresa = ${empresaId}`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function buscarUltimasMedidas(idEmpresa) {
  var instrucaoSql = ` 
  SELECT e.identificacao, e.produto, e.condicao, e.producaoEstimadaPorMin AS producaoPorMin,COUNT(r.dataRegistro) registro
  FROM esteira AS e JOIN sensor AS s ON fkEsteira = idEsteira
  JOIN registro AS r ON fkSensor = idSensor
  WHERE dataRegistro >= NOW() - INTERVAL 30 MINUTE AND fkEmpresa = ${idEmpresa}
  GROUP BY e.identificacao, e.produto, e.condicao, e.producaoEstimadaPorMin;`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}


module.exports = {
  buscarEsteirasPorEmpresa,
  buscarUltimasMedidas,
}
