'use strict';

const Service = require('egg').Service

class UserService extends Service {
    async find() {
        const user = await this.app.mysql.get('user', { id: 1 });
        // const users = await this.app.mysql.select('user');
        return { "user": user };
    }
}

module.exports = UserService