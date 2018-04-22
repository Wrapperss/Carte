'use strict';

const Service = require('egg').Service;

class UserService extends Service {
  async create(target) {
    const currentTime = this.ctx.helper.currentTime();
      const result = await app.mysql.insert('User', Object.assign({
        created_at: currentTime,
        updated_at: currentTime
      }, target))
      return result.insertId;
  }


  
}

module.exports = UserService;
