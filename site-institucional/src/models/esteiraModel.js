var database = require("../database/config");

function buscarEsteirasPorEmpresa(empresaId) {

  instrucaoSql = `SELECT * FROM esteira WHERE fkEmpresa = ${empresaId}`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

// function cadastrar(empresaId, descricao) {
  
//   instrucaoSql = `INSERT INTO (descricao, fk_empresa) esteira VALUES (${descricao}, ${empresaId})`;

//   console.log("Executando a instrução SQL: \n" + instrucaoSql);
//   return database.executar(instrucaoSql);
// }


module.exports = {
  buscarEsteirasPorEmpresa,
  // cadastrar
}
