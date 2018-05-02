'use strict';

const Service = require('egg').Service;

class CategoryService extends Service {
  async findAll() {
      const categorys = await this.app.mysql.get('Category');
      return categorys
  }
}

module.exports = CategoryService;
