var express = require("express");
var router = express.Router();

var esteiraController = require("../controllers/esteiraController");

router.get("/:empresaId", function (req, res) {
  esteiraController.buscarEsteirasPorEmpresa(req, res);
});

module.exports = router;