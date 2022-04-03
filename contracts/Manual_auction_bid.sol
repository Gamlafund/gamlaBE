//SPDX-License-Identifier:MIT
pragma solidity ^0.8.7;

contract Bidding{
    uint i;
    uint monthly_fund = 100;
    address[] Monthly_withdrawal = [0x5B38Da6a701c568545dCfcB03FcB875f56beddC4,0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2,0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db];
    uint num_iterations = 3;
    uint monthly_bidding;
    address Fund_Address;
    function Deploy( address _Fund_Address, bool consent) public payable{
        require(msg.value <= monthly_fund);
        require(Checking_Withdrawals(msg.sender, Monthly_withdrawal) == false);
        require(consent == true);
        monthly_bidding = msg.value;

    }

    function Checking_Withdrawals(address _useraddress, address[] memory) public returns(bool Withdrawn){
        uint len = Monthly_withdrawal.length;
        for (i=0;i<len;){
            if(Monthly_withdrawal[i]==_useraddress){
                return true;
            }
            i++;


        }
    }
}
