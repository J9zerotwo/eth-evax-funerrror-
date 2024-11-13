# eth-evax-funerrror

## Daily Load Transaction

This Solidity program simulates a simple transaction system where users can load funds into their accounts, transfer funds to others, and withdraw all their funds. It demonstrates basic Solidity features, including `require()`, `assert()`, and `revert()` statements for validation, making it a great learning tool for newcomers to Solidity smart contract development.

### Description

This contract is written in Solidity, a language for developing smart contracts on the Ethereum blockchain. The contract allows users to:
- Load funds into their account.
- Transfer funds to other users.
- Withdraw all funds from their account.

Using this contract, developers can learn to work with mappings to store balances, define custom events, and implement error handling for common scenarios.

### Getting Started

#### Executing the Program

To run this program, you can use [Remix](https://remix.ethereum.org/), an online IDE for Solidity.

1. **Open Remix and create a new file**:  
   - Go to [Remix](https://remix.ethereum.org/).
   - Create a new file (e.g., `DailyLoadTransaction.sol`) and paste in the following code:

   ```solidity
   // SPDX-License-Identifier: MIT
   pragma solidity ^0.8.9;

   contract DailyLoadTransaction {
       mapping(address => uint) public balances;

       event LoadSuccessful(address indexed user, uint amount);
       event TransferSuccessful(address indexed from, address indexed to, uint amount);

       function loadFunds(uint amount) public {
           require(amount > 0, "Amount must be greater than zero.");
           balances[msg.sender] += amount;
           emit LoadSuccessful(msg.sender, amount);
       }

       function transferFunds(address to, uint amount) public {
           require(amount > 0 && balances[msg.sender] >= amount, "Invalid transfer.");
           assert(to != address(0));
           balances[msg.sender] -= amount;
           balances[to] += amount;
           emit TransferSuccessful(msg.sender, to, amount);
       }

       function withdrawAll() public {
           uint balance = balances[msg.sender];
           if (balance == 0) {
               revert("No balance to withdraw.");
           }
           balances[msg.sender] = 0;
           assert(balances[msg.sender] == 0);
       }

       function getBalance(address user) public view returns (uint) {
           return balances[user];
       }
   }
   ```

2. **Compile the Code**:
   - Go to the "Solidity Compiler" tab.
   - Set the compiler version to **0.8.9** or another compatible version.
   - Click **Compile DailyLoadTransaction.sol**.

3. **Deploy the Contract**:
   - Go to the "Deploy & Run Transactions" tab.
   - Select the **DailyLoadTransaction** contract and click **Deploy**.

4. **Interacting with the Contract**:
   - **loadFunds**: Enter an amount and click **transact** to load funds into your account.
   - **transferFunds**: Specify an address and an amount to transfer to another user.
   - **withdrawAll**: Withdraw all your funds. If no funds are available, an error will display.
   - **getBalance**: Enter any user address to check the balance.

