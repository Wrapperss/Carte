'use strict';

const Controller = require('egg').Controller;

const createRule = {
  userId: 'int',
  status: 'string',
  amount: 'double',
  fare: 'double',
}

class OrderController extends Controller {
  async create() {
    const { ctx, service } = this;
    
  }
}

module.exports = OrderController;
