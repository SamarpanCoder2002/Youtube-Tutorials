exports.getController = (req, res) => {
  return res.send("Hello Viewers");
};

exports.postController = (req, res) => {
  const { name, time } = req.body;
  const { passcode } = req.params;
  const { age, cat, topic, lang } = req.query;

//   if (!age) {
//     return res.status(404).json({
//       status: false,
//       message: "Age not found",
//     });
//   }

  return res.status(200).json({
    modifiedName: `${name} Dasgupta`,
    modifiedTime: `${time} AM`,
    modifiedPasscode: `${passcode}_${Date.now()}`,
    queries: {
      age,
      cat,
      topic,
      lang,
    },
  });
};

exports.updateController = (req, res) => {
  return res.json({
    message: "Update Data",
  });
};

exports.removeController = (req, res) => {
  return res.json({
    message: "Remove/Delete Data",
  });
};
