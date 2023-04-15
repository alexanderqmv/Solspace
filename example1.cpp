// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;


contract Contract 
{
   // contract code
   address public owner;
   mapping (address => uint) public payments;
   constructor() 
   {
       owner = msg.sender; // set owner who deploy the contract 
   }

   

   function payForItem() public payable 
   {
       payments[msg.sender] = msg.value;
   }

   function withdrawAll() public 
   {
      require(msg.sender == owner, "Only the contract owner can withdraw funds!");
      address payable _to = payable(owner);
      address _thisContract = address(this);
      
      _to.transfer(_thisContract.balance);
   }
}
 
