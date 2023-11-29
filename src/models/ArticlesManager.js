const AbstractManager = require("./AbstractManager");

class ArticleManager extends AbstractManager {
  constructor() {
    super({ table: "article" });
  }

  findAll() {
    return this.database.query(`
      select a.id, a.title, a.subtitle, i.src, i.alt from  ${this.table} as a
      inner join images as i on i.id = a.image_id
    `);
  }

  find(id) {
    return this.database.query(
      `select a.id, a.title, a.subtitle, a.resume, a.text, i.src, i.alt from ${this.table} as a
      inner join images as i on i.id = a.image_id
      where a.id = ?`,
      [id]
    );
  }

  insert(article, imageId) {
    return this.database.query(
      `insert into ${this.table} (title, subtitle, text, resume, image_id) values (?, ?, ?, ?, ?)`,
      [article.title, article.subtitle, article.text, article.resume, imageId]
    );
  }

  update({ title, subtitle, resume, text, id }) {
    return this.database.query(`update ${this.table} set ? where id = ?`, [
      { title, subtitle, resume, text },
      id,
    ]);
  }

  delete(id) {
    return this.database.query(`delete from ${this.table} where id = ?`, [id]);
  }
}

module.exports = ArticleManager;
