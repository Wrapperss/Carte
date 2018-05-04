'use strict';

const Service = require('egg').Service;

class GoodsService extends Service {

async showPartGoods(categoryId) {
  let goods = await this.app.mysql.query(`
  SELECT * FROM Goods 
  WHERE id in (SELECT goodsId 
                FROM Category_Goods
                WHERE categoryId = ?)`, [categoryId]);
  return goods
}

  async create(target) {
      const result = await this.app.mysql.insert('Goods', { target });
      return result.insertId;
  }

  async find(id) {
    const goods = await this.app.mysql.get('Goods', { id });
    return goods;
  }

  async findall() {
    const goods = await this.app.mysql.get('Goods');
    return goods
  }

  async remove(id) {
    const result = await this.app.mysql.delete('Goods', { id });
    return result
  }

  async update(target) {
    const result = await this.app.mysql.update('Goods', { target })
    return result
  }
}

module.exports = GoodsService;
