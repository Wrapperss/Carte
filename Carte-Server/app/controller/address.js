'use strict';

const Controller = require('egg').Controller;

class AddressController extends Controller {
  async create() {
      const { ctx, service } = this;
      const address = await service.address.create(ctx.request.body) 
      ctx.body = address;
      ctx.status = 201;
  }


  async update() {
    const { ctx, service } = this;
    const { id  } = ctx.params;
    let address = ctx.request.body;
    address.id = id;
    await service.address.update(address) 
    ctx.body = {
        id
    };
    ctx.status = 200;
    }


  async destroy() {
    const { ctx, service } = this;
    const { id } = ctx.params;
    await service.address.remove(id);
    ctx.body = {
      id
    };
    ctx.status = 200;
  }

  async findUserAddress() {
    const { ctx, service } = this;
    const { userId } = ctx.params;
    const addresses = await service.address.findUserAddress(userId);
    ctx.body = addresses
    ctx.status = 200;
  }
}

module.exports = AddressController;
