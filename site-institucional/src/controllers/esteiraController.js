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


// function cadastrar(req, res) {
//   var descricao = req.body.descricao;
//   var idUsuario = req.body.idUsuario;

//   if (descricao == undefined) {
//     res.status(400).send("descricao está undefined!");
//   } else if (idUsuario == undefined) {
//     res.status(400).send("idUsuario está undefined!");
//   } else {


//     aquarioModel.cadastrar(descricao, idUsuario)
//       .then((resultado) => {
//         res.status(201).json(resultado);
//       }
//       ).catch((erro) => {
//         console.log(erro);
//         console.log(
//           "\nHouve um erro ao realizar o cadastro! Erro: ",
//           erro.sqlMessage
//         );
//         res.status(500).json(erro.sqlMessage);
//       });
//   }
// }

module.exports = {
  buscarEsteirasPorEmpresa,
  // cadastrar
}