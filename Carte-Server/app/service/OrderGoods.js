'use strict';

const Service = require('egg').Service;

class OrderGoodsService extends Service {
  async create(targets) {
    const result = await this.app.mysql.insert('Order_Goods', targets)
    return result.insertId;
  }
}

module.exports = OrderGoodsService;
