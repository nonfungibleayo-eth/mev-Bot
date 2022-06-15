module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 9545,
      network_id: "1337"
    }
    // live: { ... }
  }
};

module.exports = {
  
  compilers: {
    solc: {
      version: "0.6.6",
    },
  },
};