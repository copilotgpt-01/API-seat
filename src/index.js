const express = require("express");
const cors = require("cors");
const ENV = require("./config/config");
const routerApi = require("./routes");
const app = express();

const port = ENV.port || 3000;

app.use(express.json());
app.use(cors());

routerApi(app);

app.listen(port, () => {
  console.log(`server listening at http://localhost:${port}`);
});
