'use strict';

const Controller = require('egg').Controller;

class UserController extends Controller {
  async registe() {
    let meg = this.ctx.request.body
    const result = this.app.mysql.insert('user', meg);
    this.ctx.body = result
  }
}

module.exports = UserController;
