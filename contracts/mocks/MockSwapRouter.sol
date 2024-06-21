// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MockSwapRouter {
    address public WETH;
    uint256[] private swapReturnValue;

    constructor() {
        WETH = address(this);
    }

    function setSwapReturnValue(uint256[] memory returnValue) external {
        swapReturnValue = returnValue;
    }

    function swapExactETHForTokens(
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external payable returns (uint256[] memory amounts) {
        return swapReturnValue;
    }
}
