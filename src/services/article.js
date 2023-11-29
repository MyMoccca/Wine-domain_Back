const Joi = require("joi");

const articleSchema = (status) => {
  return Joi.object({
    id: Joi.number().allow(null).optional(),
    title: Joi.string().presence(status),
    subtitle: Joi.string().presence(status),
    resume: Joi.string().presence(status),
    text: Joi.string().presence(status),
    src: Joi.string().presence(status),
    alt: Joi.string().presence(status),
  });
};

module.exports = articleSchema;
