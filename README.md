# Crowdfunding contract in Solidity
This is a crowdfunding contract in Solidity that is based on the contract *"The Next 700 Smart Contract Languages" - Ilya Sergey"*. It has been modified a bit to be compatible with the current Solidity standards.

## Install
This repository contains Smart Contract code in Solidity (using Truffle). This repository doesn't contain tests for the moment. 

To install, download or clone the repo, then:
`cd solidity_crowdfunding`
`npm install`
`truffle compile`

## Interact
Follow the following steps to deploy and interact with the contract on your local machine using Ganache:

- Edit the [1_initial_migration](migrations/1_initial_migration.js) file to suit your needs (edit: `_numMinutes, _goal, { from: accounts[0]}`)
- Start your Ganache server
- Edit the network parameters in the [truffle-config](truffle-config.js) file 
- Run `truffle migrate` (the timer for the deadline starts now)

### Successful campaign (claimFunds)

```jsx
truffle migrate
truffle console

const cf = await Crowdfunding.deployed();
const accounts = await web3.eth.getAccounts();
const donation = await cf.donate({from:accounts[0], value: web3.utils.toWei('30')});
const donation2 = await cf.donate({from:accounts[1], value: web3.utils.toWei('30')});
const claim = await cf.claimFunds({from:accounts[0]}); // Only run this command once the deadline has passed
```

### Unsuccessful campaign (getRefund)
```jsx
truffle migrate
truffle console

const cf = await Crowdfunding.deployed();
const accounts = await web3.eth.getAccounts();
const donation = await cf.donate({from:accounts[0], value: web3.utils.toWei('20')});
const donation2 = await cf.donate({from:accounts[1], value: web3.utils.toWei('20')});
const refund = await cf.getRefund({from:accounts[0]}); // Only run this command once the deadline has passed
const refund = await cf.getRefund({from:accounts[1]}); // Only run this command once the deadline has passed
```

## Sources
1. [The next 700 Smart Contract Languages](https://link.springer.com/chapter/10.1007/978-3-031-01807-7_3)
2. [Truffle Suite docs](https://trufflesuite.com/docs/truffle/how-to/contracts/run-migrations/)
3. [Logrocket blog: Develop Test Deploy Smart Contracts Ganache](https://blog.logrocket.com/develop-test-deploy-smart-contracts-ganache/)
