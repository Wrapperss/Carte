'use strict';

const Controller = require('egg').Controller;

class CategoryController extends Controller {
  async showAll() {
      const { ctx, service } = this;
      const categorys = await service.category.findAll();
      ctx.body = categorys;
      ctx.status = 200;
  }
}

module.exports = CategoryController;
