'use strict';

const Controller = require('egg').Controller;

class CartController extends Controller {
  async create() {
      const { ctx, service } = this;
      let cart = ctx.request.body;
      let checkCart = await service.cart.check(cart.userId, cart.goodsId);
      if (checkCart === null) {
        const result = await service.cart.create(cart)
        ctx.body = result;
        ctx.status = 201;
      } else {
          let quantity = checkCart.quantity
          checkCart.quantity = parseInt(quantity) + 1
          const result =  await service.cart.update(checkCart);
          ctx.body = result;
          ctx.status = 200;
      }
  }

  async update() {
    const { ctx, service } = this;
    const { id } = ctx.params;
    let cart = ctx.request.body;
    cart.id = id;
    await service.cart.update(cart);
    ctx.body = {
        id
    };
    ctx.status = 200;
  }

  async destroy() {
    const { ctx, service } = this;
    const { id } = ctx.params;
    await service.cart.remove(id);
    ctx.body = {
        id
    };
    ctx.status = 200;
  }

  async showUserCart() {
    const { ctx, service } = this;
    const { userId } = ctx.params;
    let cart = await service.cart.find(userId);
    ctx.body = cart
    ctx.status = 200;
  }
}

module.exports = CartController;
