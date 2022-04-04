//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleMappingStruct {

    struct Payment{
        uint amount;
        uint timeStamp;
    }

    struct Balance{
        uint totalBalance;
        uint numberOfPayments;
        mapping(uint => Payment) payments;
    }

    mapping(address => Balance) public balanceReceived;
    /*
    so this balanceReceived form - 

    [
        {
            totalBalance,
            numberOfPayments,
            payments:{
                amount,
                timeStamp
            }
        }
    ]
    */

    function getAmount() public view returns(uint){
        return address(this).balance;
    }

    function sendMoney() public payable{
        balanceReceived[msg.sender].totalBalance += msg.value;

        //since payment is a reference type this should be "memory"
        Payment memory payment = Payment(msg.value, block.timestamp);

        //numberOfPayments is initial 0 for the payments object
        balanceReceived[msg.sender].payments[balanceReceived[msg.sender].numberOfPayments] = payment;
        balanceReceived[msg.sender].numberOfPayments++;
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
        uint balanceSend = balanceReceived[msg.sender].totalBalance;
        balanceReceived[msg.sender].totalBalance = 0;
        //transfer only the amount present in the particulat address - transfer only that amount.
        _to.transfer(balanceSend);
    }

    /*
        Withdraw enter amount of ether.
    */ 
    function withdrawAmount(address payable _to, uint _amount) public {
        require(balanceReceived[msg.sender].totalBalance >= _amount, "not  enough ether");
        balanceReceived[msg.sender].totalBalance -= _amount;

        //transfer the amount that is requestd by the user.
        _to.transfer(_amount);

    }
}