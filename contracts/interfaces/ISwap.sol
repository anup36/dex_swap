// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ISwap {
    function swapEtherToToken(address token, uint256 minAmount) external payable returns (uint256);
}
