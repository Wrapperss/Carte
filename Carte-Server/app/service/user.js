'use strict';

const Service = require('egg').Service

class UserService extends Service {
    async find() {
        const user = await this.app.mysql.get('user', { id: 1 });
        return { "user": user.nikename };
    }
}

module.exports = UserService