'use strict';

/**
 * @param {Egg.Application} app - egg application
 */
module.exports = app => {
  const { router, controller } = app;
  
  //用户信息的操作
  app.resources('users', '/api/users', 'user');
  //查看该分类下的商品 默认排序
  app.get('/api/goods/category/:categoryId', app.controller.goods.showClassifyGoods);
  //按销量排
  app.get('/api/goods/category/volume/:categoryId', app.controller.goods.showClassifyGoodsOrderByVolume);
  //按价格排
  app.get('/api/goods/category/price/:categoryId', app.controller.goods.showClassifyGoodsOrderByPrice);


  //商品详情
  app.get('/api/goods/:id', app.controller.goods.showGoodDetail);

  //所有分类
  app.get('/api/category', app.controller.category.showAll);

  //新建订单 修改订单 删除订单
  app.resources('order', '/api/order', 'order')

};
