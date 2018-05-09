'use strict';

const Service = require('egg').Service;

class OrderGoodsService extends Service {
  async create(targets) {
    const result = await this.app.mysql.insert('OrderGoods', targets)
    return result.insertId;
  }

  async findByOrderId(orderId) {
    const result = await this.app.mysql.query(`
      select * 
        from OrderGoods 
          where OrderGoods.orderId = ?`, [orderId]);
    return result;
  }
}

module.exports = OrderGoodsService;
