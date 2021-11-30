// SPDX-License-Identifier: GPL-3.0-or-later

pragma solidity ^0.8.4;

import "hardhat/console.sol";

import "./CommunityFund.sol";

contract CommunityFundFactory {
  address[] public communityFunds;

  event CommunityFundCreated(address communityFundAddress);

  function createCommunityFund(int numberOfParticipants, int recurringAmount, int duration, uint startDate, address[] memory participants) public {
    address communityFund = address(new CommunityFund(
      numberOfParticipants, recurringAmount, duration, startDate, participants
    ));

    communityFunds.push(communityFund);

    emit CommunityFundCreated(communityFund);
  }
}
