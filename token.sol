// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract Token
{
    string public constant name = "Token";
    string public constant symbol = "TOK";
    uint8  public constant decimals = 18;
    uint   public totalSupply;
    address owner_;

    mapping (address => uint) balances;
    

    function  mint(address to, uint value) public 
    {
       require(owner_ == msg.sender, "Only an owner can mint tokens!");
       require(totalSupply + value > totalSupply && balances[to] + value >= balances[to]);
       balances[to] += value; 
       totalSupply  += value;
    }




    function balanceOf(address owner) public view returns(uint)
    {
        return balances[owner];
    }
    function transfer(address to, uint value) public 
    {
        require(balances[msg.sender] >= value && balances[to] + value >= balances[to]);
        balances[msg.sender] -= value;
        balances[to] += value;
    }
}
