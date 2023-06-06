// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MyContract {
    struct Item {
        uint price;
        uint quantity;
    }

    mapping(string => Item) public items;
    mapping(address => uint) public balances;
    event ItemAdded(string, uint, uint);

    uint constant private FEE = 2;
    address private owner = 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db;

    function addItem(string memory _name, uint _price, uint _quantity) public {
        require(balances[msg.sender] >= _price, "Insufficient funds");

        uint fee = calculateFee(_price);
        uint amountToReturn = _price - fee;
        ownerTransfer(fee);
        
        senderTransfer(msg.sender, amountToReturn);
        items[_name] = Item(_price, _quantity);
        
        emit ItemAdded(_name, _price, _quantity);
    }

    function topUp(uint amount) public {
        balances[msg.sender] += amount;
    }

    function calculateFee(uint amount) private pure returns (uint) {
        return (amount * FEE) / 100;
    }

    function ownerTransfer(uint amount) private {
        balances[owner] += amount;
    }

    function senderTransfer(address sender, uint amount) private {
        balances[sender] -= amount;
    }
}
