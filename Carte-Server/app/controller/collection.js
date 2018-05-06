'use strict';

const Controller = require('egg').Controller;

class CollectionController extends Controller {
  async create() {
    const { ctx, service } = this;
    const {userId, goodsId} = ctx.params;
    const collection = await service.collection.create(ctx.request.body);
    ctx.body = collection;
    ctx.status = 201;
  }

  async remove() {
    const { ctx, service } = this;
    const {userId, goodsId} = ctx.params;
    const result = await service.collection.remove(userId, goodsId);
    ctx.body = result
    ctx.status = 200;
  }

  async findCollection() {
    const { ctx, service } = this;
    const {userId, goodsId} = ctx.params;
    const collection = await service.collection.find(userId, goodsId);
    ctx.body = collection;
    ctx.status = 200;
  }

  async collectGoods() {
      const { ctx, service } = this;
      const { userId } = ctx.params;
      const goods = await service.collection.findCollectGoods(userId);
      ctx.body = goods;
      ctx.status = 200;
  }
}

module.exports = CollectionController;
