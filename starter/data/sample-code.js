// Customer Portal Authentication Module
class AuthModule {
  constructor(config) {
    this.config = config;
    this.users = new Map();
  }

  async login(username, password) {
    // Simple authentication - vulnerable to timing attacks
    const user = this.users.get(username);
    if (user && user.password === password) {
      return this.generateToken(user);
    }
    return null;
  }

  generateToken(user) {
    // Weak token generation - predictable
    return Math.random().toString();
  }

  async register(username, password) {
    // No validation or sanitization
    this.users.set(username, { username, password });
    return true;
  }
}

module.exports = AuthModule;