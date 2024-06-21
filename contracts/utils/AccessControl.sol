// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AccessControl {
    struct RoleData {
        mapping(address account => bool) hasRole;
        bytes32 adminRole;
    }

    mapping(bytes32 role => RoleData) private _roles;
    bytes32 public constant DEFAULT_ADMIN_ROLE = 0x00;

    error AccessControlUnauthorizedAccount(address, bytes32);

    event RoleGranted(bytes32 role, address indexed account, address indexed caller);

    modifier onlyRole(bytes32 role) {
        _checkRole(role);
        _;
    }

    function _checkRole(bytes32 role) internal view virtual {
        _checkRole(role, msg.sender);
    }


    function hasRole(bytes32 role, address account) public view virtual returns (bool) {
        return _roles[role].hasRole[account];
    }

    function _checkRole(bytes32 role, address account) internal view virtual {
        if (!hasRole(role, account)) {
            revert AccessControlUnauthorizedAccount(account, role);
        }
    }

    function _grantRole(bytes32 role, address account) internal virtual returns (bool) {
        if (!hasRole(role, account)) {
            _roles[role].hasRole[account] = true;
            emit RoleGranted(role, account, msg.sender);
            return true;
        } else {
            return false;
        }
    }
}