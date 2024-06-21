// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import {ISwapRouter} from "./interfaces/ISwapRouter.sol";
import {IERC20} from "./interfaces/IERC20.sol";
import {Pausable} from "./utils/Pausable.sol";
import {AccessControl} from "./utils/AccessControl.sol";

contract ERC20Swapper is
    Initializable,
    UUPSUpgradeable,
    AccessControl,
    Pausable
{
    ISwapRouter public dexRouter;

    bytes32 public constant UPGRADER_ROLE = keccak256("UPGRADER_ROLE");
    bytes32 public constant PAUSABLE_ROLE = keccak256("PAUSABLE_ROLE");

    modifier onlyUpgrader() {
        require(hasRole(UPGRADER_ROLE, msg.sender), "UnAuthorized!");
        _;
    }

    modifier onlyPauser() {
        require(hasRole(PAUSABLE_ROLE, msg.sender), "UnAuthorized!");
        _;
    }

    // / @dev initializes the  contract
    // / @param _router The address of the DEX router
    function initialize(address _router) public initializer {
        dexRouter = ISwapRouter(_router);
        _grantRole(UPGRADER_ROLE, msg.sender);
        _grantRole(PAUSABLE_ROLE, msg.sender);
    }

    // / @dev sets the  router address
    // / @param _router The address of the new router
    function setRouter(address _router)
        external
        whenNotPaused
        onlyUpgrader
    {
        dexRouter = ISwapRouter(_router);
    }

    /// @dev swaps the `msg.value` Ether to at least `minAmount` of tokens or reverts
    /// @param token The address of destination ERC-20 token
    /// @param minAmount The minimum amount of tokens to be transferred to msg.sender
    /// @return The actual amount of transferred tokens
    function swapEtherToToken(address token, uint128 minAmount)
        external
        payable
        whenNotPaused
        returns (uint256)
    {
        require(
            msg.value <= msg.sender.balance,
            "Insufficient balance for Swap"
        );
        require(msg.value > 0, "Must send ETH to swap");

        address[] memory path = new address[](2);
        path[0] = dexRouter.WETH();
        path[1] = token;

        uint256[] memory amounts = dexRouter.swapExactETHForTokens{
            value: msg.value
        }(minAmount, path, msg.sender, block.timestamp + 10 minutes);

        require(amounts[1] >= minAmount, "Insufficient output amount");
        return amounts[1];
    }

    // / @dev pauses all transactions in the contract
    function pause() external onlyPauser {
        super._pause();
    }

    // / @dev unpauses all transactions in the contract
    function unpause() external onlyPauser {
        super._unpause();
    }

    /// @dev Required for UUPS upgradeable pattern
    function _authorizeUpgrade(address newImplementation)
        internal
        override
        onlyUpgrader
    {}
}
