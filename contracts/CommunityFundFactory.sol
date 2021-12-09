// SPDX-License-Identifier: GPL-3.0-or-later

pragma solidity ^0.8.4;

import "./CommunityFund.sol";

contract CommunityFundFactory {
  address[] public communityFunds;

  event CommunityFundCreated(address communityFundAddress);

  function createCommunityFund(
    string calldata name,
    uint requiredNbOfParticipants,
    uint recurringAmount,
    uint startDate,
    uint duration
  ) external {
    address communityFund = address(new CommunityFund(
      name, requiredNbOfParticipants, recurringAmount, startDate, duration
    ));

    communityFunds.push(communityFund);
    emit CommunityFundCreated(communityFund);
  }

  function getCommunityFunds() external view returns (address[] memory) {
    return communityFunds;
  }
}
