const express = require("express");

const router = express.Router();

const articlesControllers = require("./controllers/articlesControllers");
const productsControllers = require("./controllers/productsControllers");
const authControllers = require("./controllers/authControllers");

const { checkUserData } = require("./services/auth");
const { checkUser } = require("./services/jwt");

router.get("/articles", articlesControllers.browse);
router.get("/articles/:id", articlesControllers.read);
router.put("/articles/:id", checkUser, articlesControllers.edit);
router.post("/articles", checkUser, articlesControllers.add);
router.delete("/articles/:id", checkUser, articlesControllers.destroy);

router.get("/vins", productsControllers.browse);
router.get("/vins/:id", productsControllers.read);
router.put("/vins/:id", checkUser, productsControllers.edit);
router.post("/vins", checkUser, productsControllers.add);
router.delete("/vins/:id", checkUser, productsControllers.destroy);

router.post("/login", checkUserData, authControllers.login);

module.exports = router;
