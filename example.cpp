//SPDX-License-Identifier: UNLICENSED


pragma solidity ^0.8.9;


contract Demo
{
    
    address owner; // 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
    constructor() 
    {
        owner = msg.sender;
    }
    

    modifier onlyOwner(address _to) 
    {
        require(msg.sender == owner, "Non-Owner tried to withdraw funds from contract!");
        require(_to != address(0), "null address"); // 0x0000000000000  
        _;
    }
    

    event Paid(address indexed _from, uint _amount, uint _timestamp);

    function pay() external payable {
        emit Paid(msg.sender, msg.value, block.timestamp);
     }
    
    
    function withdraw(address payable _to) external onlyOwner(owner)
    {
        _to.transfer(address(this).balance);
    }

     
}

 
