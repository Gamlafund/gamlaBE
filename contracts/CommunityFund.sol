// SPDX-License-Identifier: GPL-3.0-or-later

pragma solidity ^0.8.4;

import "hardhat/console.sol";

struct CommunityFundStruct {
  address[] participants;

  uint recurringAmount;
  uint startDate;
  uint duration;
}

contract CommunityFund {
  CommunityFundStruct public communityFundData;

  constructor(address[] memory participants, uint recurringAmount, uint startDate, uint duration) {
    communityFundData.participants    = participants;

    communityFundData.recurringAmount = recurringAmount;
    communityFundData.duration        = duration;
    communityFundData.startDate       = startDate;
  }

  function deposit() external payable {
    // -- TODO: keep track of who is depositing and how much.
    require(msg.value == communityFundData.recurringAmount, "please deposit exact amount");
  }

  function getCommunityFundData() public view returns(CommunityFundStruct memory) {
    return communityFundData;
  }
}
