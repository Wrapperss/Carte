'use strict';

const Controller = require('egg').Controller;

const createRule = {
  userId: 'number',
  createDate: 'date',
  numbering: 'string',
  amount: 'number',
  fare: 'number',
  payment: 'number',
  status: { type: 'string', required: false },
  amount: { type: 'number', required: false },
  fare: { type: 'number', required: false },
}

class OrderController extends Controller {
  async create() {
    const { ctx, service } = this;
    const order = await service.order.create(ctx.request.body.order);
    const orderGoods = ctx.request.body.orderGoods
    for (let index = 0; index < orderGoods.length; index++) {
      orderGoods[index].orderId = order.insertId
    }
    const order_goods = await service.orderGoods.create(orderGoods)

    ctx.body = {
      order,
      order_goods
    };
    ctx.status = 201;
  }

  async update() {
    const { ctx, service } = this;
    const { id } = ctx.params;
    const order = ctx.request.body;
    order.id = parseInt(id)
    console.log(order)
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
}

module.exports = OrderController;
