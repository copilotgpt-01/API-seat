const express = require("express");

const escenarioRouter = require("./escenario.router");
const asientoRouter = require("./asiento.router");

function routerApi(app) {
  const router = express.Router();
  app.use("/api/v1", router);
  router.use("/escenarios", escenarioRouter);
  router.use("/asientos", asientoRouter);
}

module.exports = routerApi;
