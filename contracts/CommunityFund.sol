// SPDX-License-Identifier: GPL-3.0-or-later

pragma solidity ^0.8.4;

import "hardhat/console.sol";

struct CommunityFundStruct {
  address[] participants;

  int  recurringAmount;
  int  duration;
  uint startDate;
}

contract CommunityFund {
  CommunityFundStruct public communityFundData;

  constructor(address[] memory participants, int recurringAmount, int duration, uint startDate) {
    communityFundData.participants    = participants;

    communityFundData.recurringAmount = recurringAmount;
    communityFundData.duration        = duration;
    communityFundData.startDate       = startDate;
  }

  function deposit(int amount, address participant) external payable {
    // -- keep track of who is depositing and how much.
    require(msg.value == 2 ether, "please send two ether");
  }

  function getCommunityFundData() public view returns(CommunityFundStruct memory) {
    return communityFundData;
  }
}
