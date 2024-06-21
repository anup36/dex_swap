// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

abstract contract Pausable {
    bool internal _paused;

    function paused() external virtual view returns(bool) {
        return _paused;
    }

    function _pause() internal virtual {
        _paused = true;
    }

    function _unpause() internal virtual  {
        _paused = false;
    }

    modifier whenNotPaused() {
        require(!_paused, "Pausable: Paused!");
        _;
    }
}
