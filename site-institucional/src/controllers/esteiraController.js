var esteiraModel = require("../models/esteiraModel");

function buscarEsteirasPorEmpresa(req, res) {
  var idUsuario = req.params.idUsuario;

  esteiraModel.buscarEsteirasPorEmpresa(idUsuario).then((resultado) => {
    if (resultado.length > 0) {
      res.status(200).json(resultado);
    } else {
      res.status(204).json([]);
    }
  }).catch(function (erro) {
    console.log(erro);
    console.log("Houve um erro ao buscar as esteiras: ", erro.sqlMessage);
    res.status(500).json(erro.sqlMessage);
  });
}


function buscarUltimasMedidas(req, res) {

  var idEmpresa = req.params.empresa;

  esteiraModel
    .buscarUltimasMedidas(idEmpresa)
    .then(function (resultado) {
      if (resultado.length > 0) {
        res.status(200).json(resultado);
      } else {
        res.status(204).send("Nenhum resultado encontrado!");
      }
    })
    .catch(function (erro) {
      console.log(erro);
      console.log(
        "Houve um erro ao buscar as ultimas medidas.",
        erro.sqlMessage
      );
      res.status(500).json(erro.sqlMessage);
    });
}


module.exports = {
  buscarEsteirasPorEmpresa,
  buscarUltimasMedidas,
}