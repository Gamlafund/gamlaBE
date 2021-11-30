// SPDX-License-Identifier: GPL-3.0-or-later

pragma solidity ^0.8.4;

import "hardhat/console.sol";

struct CommunityFundStruct {
  int numberOfParticipants;
  int recurringAmount;
  int duration;
  uint startDate;
  address[] participants;
}

contract CommunityFund {
  CommunityFundStruct public communityFundData;

  constructor(int numberOfParticipants, int recurringAmount, int duration, uint startDate, address[] memory participants) {
    console.log("Creating community fund");

    communityFundData.numberOfParticipants = numberOfParticipants;
    communityFundData.recurringAmount      = recurringAmount;
    communityFundData.duration             = duration;
    communityFundData.startDate            = startDate;

    communityFundData.participants         = participants;
  }


  function getCommunityFundData() public view returns(CommunityFundStruct memory) {
    return communityFundData;
  }
}
