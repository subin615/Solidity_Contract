//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleMapping {
    mapping(uint => bool) public myMapping;
    mapping(address => bool) public myAddressMapping;

//change the index value from false to true
    function setIndex(uint _index) public {
        myMapping[_index] = true;
    }

    function setMyAddress() public {
        myAddressMapping[msg.sender] = true;
    }
}