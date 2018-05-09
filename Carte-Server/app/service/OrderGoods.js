'use strict';

const Service = require('egg').Service;

class OrderGoodsService extends Service {
  async create(targets) {
    const result = await this.app.mysql.insert('Order_Goods', targets)
    return result.insertId;
  }

  async findByOrderId(orderId) {
    // const result = await this.app.mysql.query('SELECT * FROM Order_Goods WHERE orderId = ?' [orderId]);
    let id = 16;
    const result = await this.app.mysql.select('Order_Goods', { id })
    return result;
  }
}

module.exports = OrderGoodsService;
