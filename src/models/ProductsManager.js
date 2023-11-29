const AbstractManager = require("./AbstractManager");

class ProductsManager extends AbstractManager {
  constructor() {
    super({ table: "product" });
  }

  findAll() {
    return this.database.query(`
      select p.id, p.winename, p.year, p.type, p.variety, p.price, p.details, w.src, w.alt from  ${this.table} as p
      inner join wineimages as w on w.id = p.wineimage_id
    `);
  }

  find(id) {
    return this.database.query(
      `select p.id, p.winename, p.year, p.type, p.variety, p.price, p.details, w.src, w.alt from  ${this.table} as p
      inner join wineimages as w on w.id = p.wineimage_id
      where p.id = ?`,
      [id]
    );
  }

  insert(product, wineimageId) {
    return this.database.query(
      `insert into ${this.table} (winename, type, variety, details, price, wineimage_id) values (?, ?, ?, ?, ?, ?)`,
      [
        product.winename,
        product.type,
        product.variety,
        product.details,
        product.price,
        wineimageId,
      ]
    );
  }

  update({ winename, type, variety, details, price, id }) {
    return this.database.query(`update ${this.table} set ? where id = ?`, [
      { winename, type, variety, details, price },
      id,
    ]);
  }
}

module.exports = ProductsManager;
