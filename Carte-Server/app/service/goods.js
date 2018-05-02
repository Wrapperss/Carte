'use strict';

const Service = require('egg').Service;

class GoodsService extends Service {
  async create(target) {
      const result = await this.app.mysql.insert('Goods', { target });
      return result.insertId;
  }
}

module.exports = GoodsService;
