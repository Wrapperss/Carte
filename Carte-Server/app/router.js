'use strict';

/**
 * @param {Egg.Application} app - egg application
 */
module.exports = app => {
  const { router, controller } = app;
  
  //用户信息的操作
  app.resources('users', '/api/users', 'user');

  app.get('/api/login/:mobile/:password', app.controller.user.login);

  app.resources('address', '/api/address', app.controller.address);

  //购物车
  app.resources('cart', '/api/cart', app.controller.cart);
  //批量删除购物车
  app.post('/api/mutilRemove/cart', app.controller.cart.mutilRemove)


  app.get('/api/cart/user/:userId', app.controller.cart.showUserCart);

  app.get('/api/user/address/:userId', app.controller.address.findUserAddress);

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
  app.resources('order', '/api/order', 'order');

  //收藏
  app.post('/api/collection', app.controller.collection.create);
  //取消收藏
  app.delete('/api/collection/:userId/:goodsId', app.controller.collection.remove);
  //查看是否收藏
  app.get('/api/collection/:userId/:goodsId', app.controller.collection.findCollection);
  //获取收藏的商品
  app.get('/api/collection/:userId', app.controller.collection.collectGoods);

  //评论
  app.post('/api/comment', app.controller.comment.create);
  app.get('/api/goods/comment/:goodsId', app.controller.comment.getGoodsComment);

  //新建订单
  app.resources('order', '/api/order', 'order');
  //查看用户的订单
  app.get('/api/order/user/:userId', app.controller.order.findUserOrder)

  //支付订单
  app.put('/api/pay/order/:userId/:orderId', app.controller.order.payForTheOrder);

  app.get('/api/home', app.controller.category.home);
};
