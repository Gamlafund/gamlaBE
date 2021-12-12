// SPDX-License-Identifier: GPL-3.0-or-later

pragma solidity ^0.8.4;

contract CommunityFund {
  string public name;

  uint public requiredNbOfParticipants;
  uint public recurringAmount;
  uint public startDate;
  uint public duration;

  struct Participant {
    uint balance;
    bool collateral;
  }

  mapping (address => Participant) public participants;
  address[] public allParticipants;

  constructor(
    string memory _name,
    uint _requiredNbOfParticipants,
    uint _recurringAmount,
    uint _startDate,
    uint _duration
  ) payable {
    require(block.timestamp < _startDate, "start date of the fund must be in the future!");
    require((msg.value == 0) || (msg.value >= recurringAmount * duration), "not enough collateral");

    name = _name;

    requiredNbOfParticipants = _requiredNbOfParticipants;
    recurringAmount          = _recurringAmount;
    duration                 = _duration;
    startDate                = _startDate;

    if (msg.value > 0) {
      participants[msg.sender].balance   += msg.value;
      participants[msg.sender].collateral = true;

      allParticipants.push(msg.sender);
    }
  }

  function deposit() external payable {
    require(participants[msg.sender].collateral == true, "collateral required");
    require(msg.value == recurringAmount, "please deposit exact amount");

    // -- TODO: only allow for one deposit per month.
  
    participants[msg.sender].balance += msg.value;
  }

  function collateral() external payable {
    require(block.timestamp < startDate, "collateral must be committed before the funds starts");
    require(allParticipants.length < requiredNbOfParticipants, "max participants reached");
    require(participants[msg.sender].collateral == false, "collateral already locked");
    require(msg.value == recurringAmount * duration, "exact collateral required");

    participants[msg.sender].balance   += msg.value;
    participants[msg.sender].collateral = true;

    allParticipants.push(msg.sender);
  }

  function getAllParticipants() external view returns (address[] memory) {
    return allParticipants;
  }
}
