require("@nomicfoundation/hardhat-toolbox");

module.exports = {
  solidity: "0.8.19",
  networks: {
    ritual: {
      url: "https://rpc.ritualfoundation.org", // RPC URL Ritual
      accounts: ["f95e981d42521e02ef2ba9501879839615e4e042682c67e459c80f7cfd99799a"] // private key akan diisi di sini
    }
  }
};
