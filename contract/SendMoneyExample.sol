// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SendMoney {
    uint public balanceAmount;
    bool public paused;
    address owner;


    constructor() public {
        owner = msg.sender;
    }
    //payable - ensures that the function can send and receive Ether
    function receiveMoney() public payable {
        balanceAmount += msg.value;
    }

    function withdrawMoney() public {
        address payable to = payable(msg.sender);
        to.transfer(this.getBalance());
    }

    //get the balance of the contract.
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    function withdrawMoneyTo(address payable _to) public {
        require(msg.sender == owner, "You are not the owner.")
        require(!paused, "Contract is paused.");
        //withdraw all the money from the contract
        _to.transfer(this.getBalance());
    }


   function setPaused(bool _paused) public {
       //require is used to check the validation for the user / any thing in the contract.
       require(msg.sender == owner, "You are not the owner");
       paused = _paused;
   } 

}