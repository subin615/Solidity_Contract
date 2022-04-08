//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract FirstProject is Ownable{

    event Log(string _function, address _from, uint _amount);

    function withdrawMoney(address payable _to, uint _amount) public onlyOwner {
        _to.transfer(_amount);
    }

    fallback() external payable {
        emit Log("fallback", msg.sender, msg.value);
    }

    receive() external payable {
        emit Log("receive", msg.sender, msg.value);
    }
}