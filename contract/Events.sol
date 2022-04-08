//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract Inherit {
    address owner;

    constructor() {
        owner = msg.sender;
    }

    //createa middleware for the functions
    modifier onlyOwner() {
        require(msg.sender == owner,"You are not the owner");
        _;
    }
}

contract EventsExample is Inherit {
    mapping(address=> uint) public tokenAvailable;


    event TokensSent(address _from, address _to, uint _amount); 
    
    constructor() {
        tokenAvailable[msg.sender] = 100;
        owner = msg.sender;
    }

//generally writing function cannot have return statements
//it can be done by using event and emit
    function sendToken(address _to, uint _amount) public onlyOwner returns(bool)  {
        tokenAvailable[msg.sender] -= _amount;
        tokenAvailable[_to] += _amount;

        //to trigger the event function
        emit TokensSent(msg.sender, _to, _amount);
        return true;
    }
}