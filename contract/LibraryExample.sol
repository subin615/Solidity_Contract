//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/utils/math/SafeMath.sol";

contract LibraryEx {
using SafeMath for uint;

mapping (address => uint) public tokenBalance;

constructor(){
    tokenBalance[msg.sender] = 1;
}

function sendMoney(address _to, uint _amount) public returns(bool) {
// tokenBalance[msg.sender] -= _amount;
//while using safemath library
tokenBalance[msg.sender]  = tokenBalance[msg.sender].sub(_amount);
tokenBalance[_to] = tokenBalance[_to].add(_amount);
return true;
}


}