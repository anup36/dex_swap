# ERC20Swapper Smart Contract

## Overview

`ERC20Swapper` is a decentralized finance (DeFi) smart contract built on the Ethereum blockchain. It facilitates seamless swapping of Ether to ERC-20 tokens using a specified decentralized exchange (DEX) router. This contract incorporates upgradeable functionality, role-based access control, pausing mechanisms, and efficient handling of swap operations.

## Features

- **Upgradeable Contract:** The contract supports upgrades via the UUPS (Universal Upgradeable Proxy Standard) pattern, allowing seamless upgrades without affecting ongoing operations.
- **Role-Based Access Control:** Equipped with role-based access control, the contract restricts specific operations to authorized addresses only. Roles include `UPGRADER_ROLE` and `PAUSABLE_ROLE`.
- **DEX Integration:** Integrates with a specified DEX router contract to perform swap operations between Ether and ERC-20 tokens.
- **Pausable Mechanism:** Allows the contract to be paused and unpaused, providing control over contract functionality.

## Installation

1. **Deploy the Contract:**
   - Deploy the `ERC20Swapper` contract on your Ethereum blockchain network.

2. **Initialize the Contract:**
   - Call the initializer function with the appropriate DEX router address.

3. **Grant Roles:**
   - Assign `UPGRADER_ROLE` and `PAUSABLE_ROLE` to authorized addresses for managing upgrades and pausing operations.

## Usage

1. **Setting Router Address:**
   - Use the `setRouter` function to update the DEX router address.
   - This ensures compatibility with a new DEX router if required.

2. **Swap Ether to ERC-20 Token:**
   - Send Ether to the contract and call the `swapEtherToToken` function to perform the swap.
   - The function automatically routes Ether to the specified ERC-20 token, handling the swap and transferring the tokens back to the sender.

3. **Pausing and Unpausing:**
   - Use the `pause` and `unpause` functions to control the contract’s operational state.

## Example

Here's a basic example of interacting with the `ERC20Swapper` contract:

```solidity
// Deploy and initialize the contract with a DEX router address

// Set a new DEX router address
address newRouterAddress = 0xNewDEXRouterAddressHere;
swapper.setRouter(newRouterAddress);

// Swap Ether to an ERC-20 token
uint128 minAmount = 1000; // Set minimum amount of tokens
swapper.swapEtherToToken(tokenAddress, minAmount);

// Pause and unpause the contract
swapper.pause();
swapper.unpause();
```

## Deployment

To deploy the contract to the Sepolia network, use the following command:

```bash
npx hardhat run scripts/deploy.js --network sepolia
```

## Upgrading

To upgrade the contract on the Sepolia network, use the following command:

```bash
npx hardhat run scripts/upgrade.js --network sepolia
```
## Verification

To verify the contract on the Sepolia network, use the following command:

```bash
npx hardhat verify {proxyContractAddress} --network sepolia
```

Replace {proxyContractAddress} with the actual deployed contract address.


## Security Considerations

- **Role Management:** Ensured that role assignments and removals are performed by trusted entities only to prevent unauthorized actions.
- **Upgradeable Security:** Carefully managed and verified contract upgrades to maintain the integrity of the deployed logic.
- **Pausable Mechanism:** Used pausing judiciously to prevent unauthorized access during potential security threats.



