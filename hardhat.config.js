require("@nomicfoundation/hardhat-toolbox");
require("@openzeppelin/hardhat-upgrades");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.24",
  networks: {
    sepolia: {
      url: "https://sepolia.infura.io/v3/3956a14355e64e05960416672e54b71f", // Your Sepolia RPC URL
      accounts: [process.env.pvtKey] // Your private key for deploying contracts
    }
  },
  etherscan: {
    apiKey: {
      sepolia: process.env.etherscanApiKey,
    }
  }
}
