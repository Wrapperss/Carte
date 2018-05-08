'use strict';

const Controller = require('egg').Controller;


class OrderController extends Controller {
  async create() {
    const { ctx, service } = this;
    const order = await service.order.create(ctx.request.body.order);
    const orderGoods = ctx.request.body.orderGoods
    for (let index = 0; index < orderGoods.length; index++) {
      orderGoods[index].orderId = order.insertId
      await service.orderGoods.create(orderGoods[index])
    }
    ctx.body = {
      order
    };
    ctx.status = 201;
  }


  async update() {
    const { ctx, service } = this;
    const { id } = ctx.params;
    const order = ctx.request.body;
    order.id = parseInt(id)
    await service.order.update(order);
    ctx.body = {
      id
    };
    ctx.state = 200;
  }

  async destroy() {
    const { ctx, service } = this;
    const { id } = ctx.params;
    await service.order.remove(id);
    ctx.body = {
      id
    };
    ctx.state = 200;
  }

  async find() {
    const { ctx, service } = this;
    const { orderId } = ctx.params;
    const result = await service.order.find(orderId);
    ctx.body = result;
    ctx.status = 200;
  }

  async findUserOrder() {
    const { ctx, service } = this;
    const { userId } = ctx.params;
    var result = [];
    const orders = await service.order.findOrderByUserId(userId);
    for (let index in orders) {
      let orderGodds = await service.orderGoods.findByOrderId(orders[index].id);
      result.push({
        "order": orders[index],
        "OrderGoods": orderGodds
      })
    }
    ctx.body = result;
    ctx.status = 200;
  }
}

module.exports = OrderController;
