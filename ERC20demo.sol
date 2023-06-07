// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

 


contract ERC20 {
    address owner;
    string public name;
    string public symbol;
    uint8  public decimals;
    uint   public totalSupply;
    mapping(address => uint) public balanceOf;

    mapping(address => mapping(address => uint256)) allowed;
    
    event Created(string, string, uint8, uint);
    event Transfer(address, address, uint);
   
    event Approval(address, address, uint);
   constructor(
        string memory _name,
        
        string memory _symbol,
        uint8 _decimals,
        
        uint256 _totalSupply) 
    {
        owner = msg.sender;
        
        name = _name;
        symbol = _symbol;
        
        decimals = _decimals;
        totalSupply = _totalSupply;
        balanceOf[owner] = _totalSupply;

        emit Created(name,symbol,decimals,totalSupply);
    }
    function transfer(address _to, uint _value) public {
        require(_to != address(0), "Invalid address");

        require(_value <= balanceOf[msg.sender], "Insufficient funds");
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        
        emit Transfer(msg.sender,_to,_value);
    }
    function allowance() public { }
    
    function approve(address _spender, uint256 _value) public returns(bool) {
        require(owner == msg.sender, "Only an owner can call the method!");
        allowed[owner][_spender] = _value;
        emit Approval(owner,_spender,_value);
        return true;
    }
    function transferFrom() public { }

    function mint(uint _amount) public {
        require(owner == msg.sender, "Only an owner can call the method!");
        totalSupply += _amount;
        balanceOf[owner] += _amount;
    }

}
