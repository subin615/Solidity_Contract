//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleMappingStruct {

    mapping(address => uint) public balanceReceived;

    function getAmount() public view returns(uint){
        return address(this).balance;
    }

    function sendMoney() public payable{
        balanceReceived[msg.sender] += msg.value;
    }
    /*
        Withdraw all the money
        @param {Address} address of eth account to add ether.
    */
    function withdrawAllMoney(address payable _to) public {
        /*
            this will result in a Check's Effect's Interaction's Pattern
        */
        // _to.transfer(this.getAmount())
        // balanceReceived[msg.sender] = 0;

        /*
            to avoid above Pattern
            --- update's first
            --- Interactions/Actions comes last;
        */
        uint balanceSend = balanceReceived[msg.sender];
        balanceReceived[msg.sender] = 0;
        //transfer only the amount present in the particulat address - transfer only that amount.
        _to.transfer(balanceSend);

    }

    /*
        Withdraw enter amount of ether.
    */ 
    function withdrawAmount(address payable _to, uint _amount) public {
        require(balanceReceived[msg.sender] >= _amount, "not  enough ether");
        balanceReceived[msg.sender] -= _amount;

        //transfer the amount that is requestd by the user.
        _to.transfer(_amount);

    }
}