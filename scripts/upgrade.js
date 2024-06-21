const { ethers, upgrades } = require("hardhat");

async function main() {
  // Assuming the proxy address is already known
  const proxyAddress = "";

  // Deploy the new version of ERC20Swapper implementation contract
  const ERC20SwapperV2 = await ethers.getContractFactory("ERC20Swapper");
 
  await upgrades.forceImport(
    proxyAddress,
    ERC20SwapperV2,
    {
      kind: 'uups',
    },
  );
 
  const upgradedImplementation = await upgrades.upgradeProxy(proxyAddress, ERC20SwapperV2);

  console.log(upgradedImplementation);

  console.log("Upgraded ERC20Swapper deployed to:", upgradedImplementation.target);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
