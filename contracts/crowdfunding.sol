// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

// Changes made:
// changed Crowdfunding cosntructor signature, because giving the constructor the same name as the contract is deprecated
// changed "now" to block.timestamp
// changed unit of tme from days to minutes for testing purposes
// changed msg.send.call.value(...)() to msg.sender.call{value: donation}("");
// changed deadline checking by adding modifier
// changed return value of call function


contract Crowdfunding {
  address owner;
  uint256 deadline;
  uint256 goal;
  mapping(address => uint256) backers;

///////////////////////////////////////////////
//                 Modifiers                 //
///////////////////////////////////////////////
  modifier onlyOwner() {
    require(msg.sender == owner, "Only owner can claim funds!");
    _;
  }

  modifier deadlineHasPassed() {
    require(block.timestamp >= deadline, "Deadline has not yet passed!"); // in the withdrawal period
    _;
  }

///////////////////////////////////////////////
//                 Functions                 //
///////////////////////////////////////////////
  constructor(uint256 numberOfMinutes, uint256 _goal) 
  { 
    owner = msg.sender;
    deadline = block.timestamp + (numberOfMinutes * 1 minutes);
    goal = _goal * 1 ether;
  }

  function donate() public payable 
  {
    require(block.timestamp < deadline); // before the fundraising deadline 
    backers[msg.sender] += msg.value;
  }

  function claimFunds() public onlyOwner deadlineHasPassed
  {
    require(address(this).balance >= goal, "Can not claim funds, funding goal has not been met."); // funding goal met 
    (bool success, ) = msg.sender.call{value: address(this).balance}("");
    require(success, "Unable to transfer funds.");
  }
  
  function getRefund() public deadlineHasPassed
  {
    require(address(this).balance < goal,"Can not refund, funding goal has been met."); // campaign failed: goal not met 
    uint256 donation = backers[msg.sender]; 
    backers[msg.sender] = 0; 
    (bool success, ) = msg.sender.call{value: donation}("");
    require(success, "Unable to transfer funds.");
  } 
}
