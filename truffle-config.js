var HDWalletProvider = require("truffle-hdwallet-provider");
module.exports = {
  contracts_build_directory: "./Web-client/src/contracts",
  // See <http://truffleframework.com/docs/advanced/configuration>
  // for more about customizing your Truffle configuration!
  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "*" // Match any network id
    },
    azure: {
      provider: new HDWalletProvider("fiber bread journey cook vendor also half check unhappy room give dynamic","http://ethqfie4f-dns-reg1.eastus.cloudapp.azure.com:8540"),
      network_id: "*",
      gasPrice:0
    },
    develop: {
      port: 8545
    }
  }
};
