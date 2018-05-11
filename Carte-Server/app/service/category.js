'use strict';

const Service = require('egg').Service;

class CategoryService extends Service {
  async findAll() {
      const categorys = await this.app.mysql.select('Category');
      return categorys;
  }

  async find(id) {
    const category = await this.app.mysql.get('Category', { id });
    return category;
  }
}

module.exports = CategoryService;
