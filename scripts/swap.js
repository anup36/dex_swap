const { ethers } = require("hardhat");
require("dotenv").config();

const CONTRACT_ADDRESS = "0xE0c0594856b11c04981c07Bb997ddF5B0344bf30";
const TOKEN_ADDRESS = "0x95ad61b0a150d79219dcf64e1e6cc01f0b64c4ce";
const MIN_AMOUNT = ethers.parseUnits("0.1", 18);
const AMOUNT_TO_SWAP = ethers.parseUnits("1.0", 18);

async function main() {
  const ERC20Swapper = await ethers.getContractFactory("ERC20Swapper");
  const erc20Swapper = ERC20Swapper.attach(CONTRACT_ADDRESS);

  const transaction = await erc20Swapper.swapEtherToToken(TOKEN_ADDRESS, MIN_AMOUNT, {
    value: AMOUNT_TO_SWAP,
  });

  const receipt = await transaction.wait();

  console.log("Swap transaction successful, transaction hash:", receipt.transactionHash);
}

main().catch((error) => {
  console.error("Error in swap:", error);
  process.exitCode = 1;
});
