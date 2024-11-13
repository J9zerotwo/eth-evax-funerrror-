// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract DailyLoadTransaction {
    mapping(address => uint) public balances;

    event LoadSuccessful(address indexed user, uint amount);
    event TransferSuccessful(address indexed from, address indexed to, uint amount);

    // Checks the amount is greater than zero and adds to the caller's balance
    function loadFunds(uint amount) public {
        require(amount > 0, "Amount must be greater than zero.");
        balances[msg.sender] += amount;
        emit LoadSuccessful(msg.sender, amount);
    }

    // Checks both amount and sender's balance
    function transferFunds(address to, uint amount) public {
        require(amount > 0 && balances[msg.sender] >= amount, "Invalid transfer.");
        assert(to != address(0)); // Ensure recipient address is valid

        balances[msg.sender] -= amount;
        balances[to] += amount;
        emit TransferSuccessful(msg.sender, to, amount);
    }

    // Checks the caller's balance
    function withdrawAll() public {
        uint balance = balances[msg.sender];
        if (balance == 0) {
            revert("No balance to withdraw."); // Revert if balance is zero
        }

        balances[msg.sender] = 0;
        assert(balances[msg.sender] == 0); // Ensure balance is reset to zero
    }

    // Returns the balance of any specified address
    function getBalance(address user) public view returns (uint) {
        return balances[user];
    }
}
