'use strict';

const Service = require('egg').Service;

class CollectionService extends Service {
  async create(target) {
    const result = await this.app.mysql.insert('Collection', target);
    return result.insertId;
  }

  async remove(userId, goodsId) {
    const result = await this.app.mysql.delete('Collection', { userId, goodsId });
    return result;
  }

  async find(userId, goodsId) {
    const collection = await this.app.mysql.get('Collection', { userId, goodsId });
    return collection;
  }

  async findCollectGoods(userId) {
    let goods = await this.app.mysql.query(`
    SELECT * 
      FROM Goods
      WHERE id in (SELECT goodsId FROM Collection WHERE userId = ?)
    `, [userId]);
    return goods;
  }
}

module.exports = CollectionService;
