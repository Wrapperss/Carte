'use strict';

const Controller = require('egg').Controller;

class CommentController extends Controller {
  async create() {
      const { ctx, service } = this;
      const comment = await service.comment.create(ctx.request.body);
      ctx.body = comment;
      ctx.status = 201;
  }

  async getGoodsComment() {
      const { ctx, service } = this;
      const { goodsId } = ctx.params;
      const comments = await service.comment.find(goodsId);
      ctx.body = comments;
      ctx.status = 200
  }

}

module.exports = CommentController;
