'use strict';

/**
 * @param {Egg.Application} app - egg application
 */
module.exports = app => {
  const { router, controller } = app;
  
  //用户信息的操作
  app.resources('users', '/api/users', 'user');
  //查看该分类下的商品
  app.get('/api/goods/category/:categoryId', app.controller.goods.showClassifyGoods);
  //商品详情
  app.get('/api/goods/:id', app.controller.goods.showGoodDetail);

  //所有分类
  app.get('/api/category', app.controller.category.showAll);
};
