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
    ctx.body = order.insertId;
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

  async payForTheOrder() {
    const { ctx, service } = this;
    const { userId, orderId } = ctx.params;
    const user = await service.user.find(userId);
    const order = await service.order.find(orderId);
    if (parseFloat(user.balance) < parseFloat(order.payment)) {
      ctx.body = { "error": "余额不足" };
      ctx.status = 403;
    } else {
      user.balance = parseFloat(user.balance) - parseFloat(order.payment);
      const userResult = await service.user.update(user);
      order.status = "待发货";
      const orderResult = await service.order.update(order);
      ctx.body = {
        userResult,
        orderResult
      }
      ctx.status = 201
    }
  }
}

module.exports = OrderController;
