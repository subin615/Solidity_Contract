// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Store {
    uint amount;

    function getAmount() public view returns (uint) {
        return amount;
    }

    function addAmount(uint _amount) public {
        amount += _amount;
    }
}