// SPDX-License-Identifier: GPL-3.0-or-later

pragma solidity ^0.8.4;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";

contract CommunityFund {
    string public name;
    IERC20 public USDT;
    uint256 public requiredNbOfParticipants;
    uint256 public recurringAmount;
    uint256 public startDate;
    uint256 public duration;

    struct Participant {
        uint256 balance;
        bool collateral;
    }

    mapping(address => Participant) public participants;
    address[] public allParticipants;

    constructor(
        address _from,
        string memory _name,
        uint256 _requiredNbOfParticipants,
        uint256 _recurringAmount,
        uint256 _startDate,
        uint256 _duration
    ) payable {
        USDT = IERC20(0xdAC17F958D2ee523a2206206994597C13D831ec7);
        require(
            block.timestamp < _startDate,
            "start date of the fund must be in the future!"
        );
        require(
            (msg.value == 0) ||
                (msg.value >= (_recurringAmount * _duration * 120) / 100),
            "not enough collateral"
        );

        name = _name;

        requiredNbOfParticipants = _requiredNbOfParticipants;
        recurringAmount = _recurringAmount;
        duration = _duration;
        startDate = _startDate;

        if (msg.value > 0) {
            participants[_from].balance += msg.value;
            participants[_from].collateral = true;

            allParticipants.push(_from);
        }
    }

    function deposit() external payable {
        require(
            participants[msg.sender].collateral == true,
            "collateral required"
        );
        require(msg.value == recurringAmount, "please deposit exact amount");

        // -- TODO: only allow for one deposit per month.

        participants[msg.sender].balance += msg.value;
    }

    function collateral() external payable {
        require(
            block.timestamp < startDate,
            "collateral must be committed before the funds starts"
        );
        require(
            allParticipants.length < requiredNbOfParticipants,
            "max participants reached"
        );
        require(
            participants[msg.sender].collateral == false,
            "collateral already locked"
        );
        require(
            msg.value >= (recurringAmount * duration * 120) / 100,
            "minimum collateral required"
        );

        participants[msg.sender].balance += msg.value;
        participants[msg.sender].collateral = true;

        allParticipants.push(msg.sender);
    }

    function getAllParticipants() external view returns (address[] memory) {
        return allParticipants;
    }
}
