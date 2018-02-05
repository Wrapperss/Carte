'use strict';

const Controller = require('egg').Controller;

class HomeController extends Controller {
  async index() {
    this.ctx.body = { "testt": true };
    console.log(this.ctx.request.method);
  }

  async userr() {
    this.ctx.body = { "queryString": this.ctx.query.user };
    console.log(this.ctx.request.header)
  }

  async d() {
    const ctx = this.ctx
    const user = await ctx.service.user.find()
    this.ctx.body = { "body": user }
  }
}

module.exports = HomeController;
