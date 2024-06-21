const { expect } = require("chai");
const { ethers, upgrades } = require("hardhat");

describe("ERC20Swapper Unit Tests", function () {
  let erc20Swapper, owner, addr1, addr2, dexRouter;

  before(async function () {
    [owner, addr1, addr2] = await ethers.getSigners();

    const MockDexRouter = await ethers.getContractFactory("MockSwapRouter");
    dexRouter = await MockDexRouter.deploy();

    const ERC20Swapper = await ethers.getContractFactory("ERC20Swapper");
    erc20Swapper = await upgrades.deployProxy(ERC20Swapper, [dexRouter.target], { initializer: 'initialize' });
  });

  it("should set the DEX router address", async function () {
    const newDexRouterAddress = addr1.address;
    await erc20Swapper.setRouter(newDexRouterAddress);
    expect(await erc20Swapper.dexRouter()).to.equal(newDexRouterAddress);
  });

  it("should pause and unpause the contract", async function () {
    await erc20Swapper.pause();
    expect(await erc20Swapper.paused()).to.be.true;
    await erc20Swapper.unpause();
    expect(await erc20Swapper.paused()).to.be.false;
  });

  it("should swap Ether to ERC-20 token", async function () {
    const tokenAddress = addr2.address;
    const minAmount = ethers.parseUnits("10", 18);
    const swapAmount = ethers.parseUnits("1", "ether");

    await dexRouter.setSwapReturnValue([swapAmount, minAmount]);

    await erc20Swapper.connect(addr1).swapEtherToToken(tokenAddress, minAmount, { value: swapAmount });
  });

  it("should revert if paused", async function () {
    await erc20Swapper.pause();
    const tokenAddress = addr2.address;
    const minAmount = ethers.parseUnits("10", 18);
    const swapAmount = ethers.parseUnits("1", "ether");

    await expect(
      erc20Swapper.connect(addr1).swapEtherToToken(tokenAddress, minAmount, { value: swapAmount })
    ).to.be.revertedWith("Pausable: Paused!");

    await erc20Swapper.unpause();
  });
});
