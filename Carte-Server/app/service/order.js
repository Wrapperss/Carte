'use strict';

const Service = require('egg').Service;

class OrderService extends Service {
  async create(target) {
      const result = await this.app.mysql.insert('Order', target);
      return result;
  }

  async find(id) {
    const order = await this.app.mysql.get('Order', { id });
    console.log(order);
    return order;
  }

  async findAll() {
    const orders = await this.app.mysql.select('Order');
    return orders
  }

  async remove(id) {
    const result = await this.app.mysql.delete('Order', { id });
    return result
  }

  async update(target) {
    const result = await this.app.mysql.update('Order', target)
    return result.affectedRows === 1;
  }

  async findOrderByUserId(userId) {
    const orders = await this.app.mysql.select('Order', { userId });
    return orders;
  }
}

module.exports = OrderService;
