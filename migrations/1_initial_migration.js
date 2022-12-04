var Crowdfunding = artifacts.require("Crowdfunding");

module.exports = function(deployer, _, accounts) {
  const _numMinutes = 1;
  const _goal = 50;
  deployer.deploy(Crowdfunding, _numMinutes, _goal, { from: accounts[0]});
};