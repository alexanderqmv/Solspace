// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EtherTransfer {
    uint8 public variable = 254;

    /* increment and decrement func impl*/
    function increment() public{
        unchecked { ++variable; } 
    }
    function decrement() public{ --variable; }
    //////////////////////////////////////


    /// some manipulation  

    string public myStr = "hello";
    function demo(string memory setVal) public 
    {
        myStr = setVal;
    }
    //////////////////////////////////////

    address public myAddr = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    
    
    // returns current balance 
    function getBalanceThis() public view returns (uint)
    {
        return myAddr.balance;
    }
    

    // returns balance of address which we set as args
    function getBalance(address other) public view returns (uint)
    {
        return other.balance;
    }
    function receiveFunds() public payable {  
        payments[msg.sender] = msg.value;
    }
    function transferTo(address target, uint amount) public 
    {
        address payable _to = payable(target);
        _to.transfer(amount);
    }
    mapping (address => uint) public payments; //storage
        
    bytes10 public some_bytes = "testpleas";
}
