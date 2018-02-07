'user strict'

module.exports = app => {
    class Model {
        constructor(ctx) {
            this.ctx = ctx;
        }

        async getClient(clientId, clientSerect) {
            const user = this.ctx.app.mysql.get('user', { id: 1});
            if (username != user.mobile || password != user.password) {
                return;
            }
            return user
        }

        async getUser(username, password) {
            const user = this.ctx.app.mysql.get('user', { id: 1});
            if (username != user.mobile || password != user.password) {
                return;
            }
            return user
        }

        async getAccessToken(bearerToken) {
            const token = this.ctx.app.mysql.get('user', { id: 1}).token;
            return token
        }

        async saveToken(token, client, user) {
            return token
        }
    }

    return Model
};