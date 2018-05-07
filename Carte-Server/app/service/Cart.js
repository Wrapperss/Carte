'use strict';

const Service = require('egg').Service;

class CartService extends Service {
  async create(target) {
      const result = await this.app.mysql.insert('Cart', target);
      return result.insertId;
  }

  async find(userId) {
    const cart = await this.app.mysql.select('Cart', { userId });
    return cart
  }

  async remove(id) {
    const result = await this.app.mysql.delete('Cart', { id });
    return result.affectedRows === 1;
  }

  async update(target) {
    const result = await this.app.mysql.update('Cart', target);
    return result.affectedRows === 1;
  }

  async check(userId, goodsId) {
    const cart = await this.app.mysql.get('Cart', { userId, goodsId });
    return cart
  }
}

module.exports = CartService;
