'use strict';

const Service = require('egg').Service;

class AddressService extends Service {
  async create(target) {
    const result = await this.app.mysql.insert('Address', target);
    return result;
  }

  async remove(id) {
      const result = await this.app.mysql.delete('Address', { id });
      return result;
  }

  async update(target) {
      const result = await this.app.mysql.update('Address', target);
      return result;
  }

  async findUserAddress(userId) {
    const addresses = await this.app.mysql.query(`
    SELECT * FROM Address WHERE userId = ?
    `, [userId]);
    return addresses
  }
}

module.exports = AddressService;
