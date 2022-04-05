// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ExceptionExample {
    mapping(address => uint64) public balanceReceived;

    function getMoney() public payable {
        //assert is used for checking the interanl state variable / invariants.
        assert(balanceReceived[msg.sender] + uint64(msg.value) >= balanceReceived[msg.sender]);
        balanceReceived[msg.sender] += uint64(msg.value);
    }

    function setMoney(address payable _to, uint64 _amount) public {
        //require is for input validation.
        require(_amount<= balanceReceived[msg.sender],"You don't have enough ether!.");
        assert(balanceReceived[msg.sender] >= balanceReceived[msg.sender] - _amount);
        balanceReceived[msg.sender] -= _amount;
        _to.transfer(_amount);
    }
}