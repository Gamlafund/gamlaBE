// SPDX-License-Identifier: GPL-3.0-or-later

pragma solidity ^0.8.4;

contract CommunityFund {
  address[] public participants;

  uint public recurringAmount;
  uint public startDate;
  uint public duration;

  constructor(address[] memory _participants, uint _recurringAmount, uint _startDate, uint _duration) {
    participants    = _participants;

    recurringAmount = _recurringAmount;
    duration        = _duration;
    startDate       = _startDate;
  }

  function deposit() external payable {
    // -- TODO: keep track of who is depositing and how much.
    require(msg.value == recurringAmount, "please deposit exact amount");
  }
}
