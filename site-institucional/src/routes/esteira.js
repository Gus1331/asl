var express = require("express");
var router = express.Router();

var esteiraController = require("../controllers/esteiraController");

router.get("/:empresaId", function (req, res) {
  esteiraController.buscarEsteirasPorEmpresa(req, res);
});

// router.post("/cadastrar", function (req, res) {
//   aquarioController.cadastrar(req, res);
// })

module.exports = router;