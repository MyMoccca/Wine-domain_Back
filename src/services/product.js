const Joi = require("joi");

const productSchema = (status) => {
  return Joi.object({
    id: Joi.number().allow(null).optional(),
    winename: Joi.string().presence(status),
    year: Joi.string().presence(status),
    type: Joi.string().presence(status),
    variety: Joi.string().presence(status),
    src: Joi.string().presence(status),
    alt: Joi.string().presence(status),
    details: Joi.string().allow(null).optional(),
    price: Joi.string().allow(null).optional(),
  });
};

module.exports = productSchema;
