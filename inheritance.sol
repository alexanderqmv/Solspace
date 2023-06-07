// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Ownable 
{
    address public owner_;  
    
    constructor(address ownerOverride ) {  owner_ = ownerOverride == address(0) ? msg.sender : ownerOverride; }
    /* Parent contract */
    
    modifier onlyOwner()
    {  require(owner_ == msg.sender, "not an owner!"); _; }

    function withdraw(address payable _to) public virtual onlyOwner 
    { payable(owner_).transfer(address(this).balance); }

}
abstract contract Balances is Ownable
{

    function getBalance() public view onlyOwner returns(uint)
    { return address(this).balance; }

    function withdraw(address payable _to) public override virtual onlyOwner 
    { _to.transfer(getBalance()); }
}


/* non-dynamic: contract Contract is Ownable(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4), Balances */
contract Contract is Ownable, Balances
{
    constructor(address _owner) Ownable(_owner) { }
    
    function withdraw(address payable _to) public  override(Ownable,Balances) onlyOwner 
    {   super.withdraw(_to); /* or Balances.withdraw(_to); // refer to the contract up the hierarchy (1)*/ 
        require(_to != address(0), "null-address");
    }
}
