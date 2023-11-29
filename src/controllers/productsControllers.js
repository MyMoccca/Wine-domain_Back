const models = require("../models");
const productSchema = require("../services/product");

const browse = (req, res) => {
  models.products
    .findAll()
    .then(([rows]) => {
      res.send(rows);
    })
    .catch((err) => {
      console.error(err);
      res.sendStatus(500);
    });
};

const read = (req, res) => {
  models.products
    .find(req.params.id)
    .then(([rows]) => {
      if (rows[0] == null) {
        res.sendStatus(404);
      } else {
        res.send(rows[0]);
      }
    })
    .catch((err) => {
      console.error(err);
      res.sendStatus(500);
    });
};

const edit = async (req, res) => {
  const product = req.body;

  // TODO validations (length, format...)

  product.id = parseInt(req.params.id, 10);
  try {
    const { error } = productSchema("optional").validate(product, {
      abortEarly: false,
    });
    if (error) throw new Error(error);
    await models.wineimages.update(product.src, product.alt, product.id);
    await models.products.update(product);
    res.sendStatus(204);
  } catch (error) {
    console.error(error);
    res.sendStatus(500);
  }
};

const add = async (req, res) => {
  const product = req.body;

  try {
    const { error } = productSchema("required").validate(product, {
      abortEarly: false,
    });
    if (error) throw new Error(error);

    const image = await models.images.insert(product.src, product.alt);
    if (image[0].affectedRows === 1) {
      const productCreated = await models.products.insert(
        product,
        image[0].insertId
      );
      res
        .location(`/vins/${productCreated[0].insertId}`)
        .status(201)
        .json({ ...product, id: productCreated[0].insertId });
    }
  } catch (error) {
    console.error(error);
    res.sendStatus(500);
  }
};

const destroy = async (req, res) => {
  try {
    const articleToDelete = await models.articles.delete(req.params.id);
    if (articleToDelete[0].affectedRows === 1) {
      res.sendStatus(204);
    } else {
      res.sendStatus(404);
    }
  } catch (error) {
    console.error(error);
    res.sendStatus(500);
  }
};

module.exports = {
  browse,
  read,
  edit,
  add,
  destroy,
};
