const express = require("express");
const {
  getController,
  postController,
  updateController,
  removeController,
} = require("../controllers/first_controller");
const router = express.Router();

router.get("/hello", getController);

router.post("/send-data/:passcode", postController);

router.put("/update-data/:passcode", updateController);

router.delete("/delete-data/:passcode", removeController);

module.exports = router;
