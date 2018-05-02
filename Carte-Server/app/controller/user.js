'use strict';

const Controller = require('egg').Controller;

const createRule = {
  name: {type: 'string', required: false},
  mobile: 'string',
  email: {type: 'string', required: false},
  blance: {type: 'string', required: false}
}

class UserController extends Controller {
  async create() {
    const { ctx, service } = this;
    ctx.validate(Object.assign(createRule, {
      password: { type: 'string', required: true },
    }));
    const user = await service.user.create(ctx.request.body);
    ctx.body = {
      user
    };
    ctx.status = 201
  }

  async show() {
    const { ctx, service } = this;
    const { id } = ctx.params;
    const user = await service.user.find(id);
    ctx.body = {
      user
    };
    ctx.status = 200;
  }

  async update() {
    const { ctx, service } = this;
    const { id } = ctx.params;
    ctx.validate(Object.assign(createRule, {
      password: { type: 'string', required: false },
    }));
    let user = ctx.request.body;
    user.id = id
    await service.user.update(user);
    ctx.body = {
      id
    };
    ctx.status = 200;
  }

  async destroy() {
    const { ctx, service } = this;
    const { id } = ctx.params;
    await service.user.remove(id);
    ctx.body = {
      id
    };
    ctx.status = 200
  }
}

module.exports = UserController;
