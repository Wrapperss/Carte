'use strict';

const Controller = require('egg').Controller;

class GoodsController extends Controller {
  async showClassifyGoods() {
      const { ctx, service } = this;
      const { categoryId } = ctx.params;
      const goods = await service.goods.showPartGoods(categoryId);
      ctx.body = goods;
      ctx.state = 200;
  }

  async showClassifyGoodsOrderByVolume() {
      const {ctx, service} = this;
      const { categoryId } = ctx.params;
      const goods = await service.goods.showPartGoodsOrderByVolume(categoryId);
      ctx.body = goods;
      ctx.state = 200;
  }

  async showClassifyGoodsOrderByPrice() {
    const {ctx, service} = this;
    const { categoryId } = ctx.params;
    const goods = await service.goods.showClassifyGoodsOrderByPrice(categoryId);
    ctx.body = goods;
    ctx.state = 200;
}

  async showGoodDetail() {
      const { ctx, service} = this;
      const { id } = ctx.params;
      const goods = await service.goods.find(id);
      ctx.body = goods
      ctx.state = 200
  }
}

module.exports = GoodsController;
