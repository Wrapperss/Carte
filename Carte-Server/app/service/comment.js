'use strict';

const Service = require('egg').Service;

class CommentService extends Service {
  async create(target) {
    const result = await this.app.mysql.insert('Comment', target);
    return result.insertId;
  }

  async find(id) {
    const comment = await this.app.mysql.get('Comment', { id });
    return comment
  }

  async findAll() {
    const comments = await this.app.mysql.get('Comment');
    return comments;
  }

  async findByGoods(goodsId) {
      const comments = await this.app.mysql.query(`select * from Comment where goodsId = ? `, [ goodsId ] );
      return comments
  }
}

module.exports = CommentService;
