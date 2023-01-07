const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");
const app = express();

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(cors());

const firstRoutePath = require("./router/first_route");

app.use("/api", firstRoutePath);

const PORT = process.env.PORT || 8000;

app.listen(PORT, () => {
  console.log(`Server is running at port ${PORT}`);
});
