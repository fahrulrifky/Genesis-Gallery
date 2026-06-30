require("@nomicfoundation/hardhat-toolbox");

module.exports = {
  solidity: "0.8.19",
  networks: {
    ritual: {
      url: "https://rpc.ritualfoundation.org", 
      accounts: process.env.PRIVATE_KEY ? [process.env.PRIVATE_KEY] : [] 
    }
  }
};
