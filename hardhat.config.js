require("@nomicfoundation/hardhat-toolbox");

module.exports = {
  solidity: "0.8.19",
  networks: {
    ritual: {
      url: "https://rpc.ritualfoundation.org", // RPC URL Ritual
      accounts: [] // private key akan diisi di sini
    }
  }
};
