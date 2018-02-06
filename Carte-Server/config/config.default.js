'use strict';

module.exports = appInfo => {
  const config = {};

  // use for cookie sign key, should change to your own and keep security
  config.keys = appInfo.name + '_1516678145399_2380';

  // add your config here
  config.middleware = [];

  config.mysql = {
    client: {
      // host
      host: '127.0.0.1',
      // 端口号
      port: '3306',
      // 用户名
      user: 'root',
      // 密码
      password: '12345',
      // 数据库名
      database: 'Carte',    
    },
    // 是否加载到 app 上，默认开启
    app: true,
    // 是否加载到 agent 上，默认关闭
    agent: false,
  };

  //关闭Crsrf防范
  config.security= {
    csrf: {
      enable: false,
    },
  };

  return config;
};