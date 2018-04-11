'use strict';

/**
 * @param {Egg.Application} app - egg application
 */
module.exports = app => {
  const { router, controller } = app;
  router.get('/', controller.home.index);

  router.get('/user', controller.home.userr);

 router.post('/user/registe', controller.user.registe);
 router.post('/user/login', controller.user.login)

};
