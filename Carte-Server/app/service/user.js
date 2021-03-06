'use strict';

const Service = require('egg').Service;

class UserService extends Service {
  async create(target) {
      const result = await this.app.mysql.insert('User', target);
      return result.insertId;
  }

  async find(id) {
    const user = await this.app.mysql.get('User', { id });
    return user
  }

  async findAll() {
    const users = await this.app.mysql.get('User');
    return users;
  }

  async remove(id) {
    const result = await this.app.mysql.delete('User', { id });
    return result.affectedRows === 1;
  }
  
  async update(target) {
    const currentTime = this.ctx.helper.currentTime();
    const result = await this.app.mysql.update('User', Object.assign({
      updated_at: currentTime
    }, target));
    return result.affectedRows === 1;
  }

  async login(mobile, password) {
    const result = await this.app.mysql.get('User', {mobile, password});
    return result;
  }
}

module.exports = UserService;
