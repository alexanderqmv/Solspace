// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


 
contract Token
{
    string public constant name = "Token";
    string public constant symbol = "TOK";
    uint8  public constant decimals = 2;
    uint   public totalSupply;
    address owner_;

    
    mapping (address => uint) balances;
    mapping (address => mapping(address => uint)) allowed;

    //modifier Owner() { require(owner_ == msg.sender, "Not an owner!"); _; }

    event Transfer(address indexed _from, address indexed _to, uint _value);
    event Approval(address indexed _from, address indexed _to, uint _value);
    
    
    
    function mint(address to, uint value) public
    {
       require(totalSupply + value > totalSupply && balances[to] + value >= balances[to]);
       balances[to] += value; 
       totalSupply  += value;
    }

    function balanceOf(address owner) public view returns(uint)
    {
        return balances[owner];
    }
    function transfer(address _to, uint _value) public 
    {
        require(balances[msg.sender] >= _value && balances[_to] + _value >= balances[_to]);
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
    }
    function allowance(address _owner, address _spender) public view returns(uint)
    {
        return allowed[_owner][_spender];
    }

    function transferFrom(address _from, address _to, uint _value) public 
    {
        require(balances[_from] >= _value && balances[_to] + _value >= balances[_to] && allowed[_from][msg.sender] >= _value);
        balances[_from] -= _value;
        balances[_to] += _value;
        allowed[_from][msg.sender] -= _value;
        emit Transfer(_from, _to, _value);
    }

    function approve(address _spender, uint _value) public 
    {
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
    }
}
