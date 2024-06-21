const { ethers, upgrades } = require("hardhat");

async function main() {
  const Swapper = await ethers.getContractFactory("ERC20Swapper");
  const uniswapRouter = process.env.uniswapRouter;

  const swapperContract = await upgrades.deployProxy(
    Swapper,
    [uniswapRouter],
    { initializer: "initialize" },
    { kind: "uups" }
  );

  console.log("Swapper deployed to:", swapperContract.target);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
