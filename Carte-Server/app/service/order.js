'use strict';

const Service = require('egg').Service;

class OrderService extends Service {
  async create(target) {
      const result = await this.app.mysql.insert('Order', target);
      return result;
  }

  async find(id) {
    const order = await this.app.mysql.get('Order', { id });
    return order;
  }

  async findall() {
    const orders = await this.app.mysql.get('Order');
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
}

module.exports = OrderService;
