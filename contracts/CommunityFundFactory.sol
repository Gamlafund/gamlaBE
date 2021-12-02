// SPDX-License-Identifier: GPL-3.0-or-later

pragma solidity ^0.8.4;

import "hardhat/console.sol";

import "./CommunityFund.sol";

contract CommunityFundFactory {
  address[] public communityFunds;

  event CommunityFundCreated(address communityFundAddress);

  function createCommunityFund(
    address[] memory participants, uint recurringAmount, uint startDate, uint duration
  ) public {
    address communityFund = address(new CommunityFund(
      participants, recurringAmount, duration, startDate
    ));

    communityFunds.push(communityFund);

    emit CommunityFundCreated(communityFund);
  }
}
