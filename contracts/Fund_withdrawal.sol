//SPDX-License-Identifier:MIT
pragma solidity ^0.8.7;

contract Fund_Withdrawal{
    uint count = 0;

    struct Details{
        address fund_address;
        uint amount;
        uint month_no;
    }

    struct Details_2{
        address participant_address;
        address fund_address;
        uint amount;
        uint month_no;

    }

    Details details;
    Details_2 details_2;
    mapping(address=>Details) auction_details;
    mapping(uint=>Details_2) winner_register;


    function Winner_Register(address p_address, address f_address, uint _amount, uint _month_no) public{
        details_2 = Details_2(p_address, f_address,_amount,_month_no );
        winner_register[count] = details_2;
        count=count+1;


    }

    function Auction_Details(address p_address, address f_address, uint _amount, uint _month_no) public{
        details = Details( f_address,_amount,_month_no );
        auction_details[p_address] = details;



    }

}
