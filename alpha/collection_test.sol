// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;




contract Contract {
    address public owner;
    uint public target_amount;
    uint private deadline;
    uint public amount_count;
    uint public totalTransactions;
    
    address payable[] private contributors;
    mapping (address => uint) public donations;

    constructor(uint target, uint dline__seconds)
    {
        owner = msg.sender;
        target_amount = target;
        deadline = block.timestamp + dline__seconds;
    }
    
    modifier timer() { require(block.timestamp < deadline,"The fundraising time has passed"); _; } 
    event NewDonate(uint amount, address from);

    function donate() public payable timer
    { 
        require(msg.value >=  0.1 ether, "Minimum amount 0.1 ETH");
        amount_count += msg.value;
        donations[msg.sender] += msg.value;
        contributors.push(payable(msg.sender));
        
        ++totalTransactions;
        emit NewDonate(msg.value, msg.sender);

    }
    function withdraw() public
    { 
        require(owner == msg.sender, "Only an owner can withdraw funds from contract!");
        payable(owner).transfer(address(this).balance);
    }
    function refund() public timer
    {
        for (uint i = 0; i < contributors.length; ++i) 
        {
            address payable temp = contributors[i];
            uint balance = donations[temp];
            if (balance > 0)
            {
                donations[temp] = 0;
                temp.transfer(balance);
                amount_count -= balance;
            }
        }   
    }
}
