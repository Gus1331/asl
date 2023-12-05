var express = require("express");
var router = express.Router();

var esteiraController = require("../controllers/esteiraController");

// router.get("/:empresaId", function (req, res) {
//   esteiraController.buscarEsteirasPorEmpresa(req, res);
// });

router.get("/ultimas/:idEmpresa", function (req, res) {
  esteiraController.buscarUltimasMedidas(req, res);
});

module.exports = router;
