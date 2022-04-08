//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract FunctionExamples {
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    receive() external payable {}

    // to accept ether to the contract
    // function receiveMoney() public payable {}

    //pure function can't call other function only calls other pure function
    //pure function does not interact with storage variables.
    function convertWeitoEther(uint256 _amount) public pure returns (uint256) {
        return _amount / 1 ether;
    }

    //view function can call other pure and view function but not writing function.
    function getOwner() public view returns (address) {
        return owner;
    }

    function getAmount() public view returns(uint) {
        return address(this).balance;
    }

    //fallback function if there are no payable function in the contract
    fallback() external payable {
        // receiveMoney();
    }
}