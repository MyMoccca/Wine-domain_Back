// const models = require("../models");
const { checkPassword } = require("../services/auth");
const models = require("../models");
const { createJwt } = require("../services/jwt");

const login = async (req, res) => {
  // 1ère étape : vérification des données du req.body
  const [user] = await models.users.findOne(req.body.email);
  // 2ème étape : Vérifier si l'email est bon et si mot de passe correspond
  if (
    user[0] &&
    (await checkPassword(user[0].encrypt_pwd, req.body.password))
  ) {
    // equivaut à user
    const token = createJwt({ email: req.body.email, role: "admin" });

    res
      .status(200)
      .cookie("blog_token", token, {
        httpOnly: true,
      })
      .json({ msg: "Connected" });
  } else {
    res.status(401).json({ msg: "Wrong credentials" });
  }
};

module.exports = {
  login,
};
