//Harcoins ICO

// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

contract Harcoins_ICO{
    //Total number of Har coins issued
    uint public max_harcoins = 1000000;

    //Conversion rate to harcoins for 1 usd
    uint public usd_to_harcoins = 100;

    //Total coins bought
    uint public total_harcoins_bought = 0;

    //Investor address mapping to its equity in harcoins and dollars
    mapping(address => uint) equity_harcoins;
    mapping(address => uint) equity_usd;
    
    //Checking for harcoins left using modifiers
    modifier can_buy_harcoins(uint usd_invested){
        require(usd_invested*usd_to_harcoins<=(max_harcoins-total_harcoins_bought), "Not enough coins left");
        _;
    }

    //Getter functions for equity and usd of an investor
    function investor_harcoins(address investor) external view returns(uint){
        return equity_harcoins[investor];
    }
    function investor_usd(address investor) external view returns(uint){
        return equity_usd[investor];
    }

    //Buy harcoins
    function buy_harcoins(uint usd_invested) external can_buy_harcoins(usd_invested){
        uint har_coins = usd_invested*usd_to_harcoins;
        equity_harcoins[msg.sender] += har_coins;
        equity_usd[msg.sender] += usd_invested;
        total_harcoins_bought += har_coins;
    }

    //Selling harcoins
    function selling_harcoins (uint harcoins_sell) external{
        require(equity_harcoins[msg.sender]>=harcoins_sell, "You dont have enough coins to be sold");
        uint usd = harcoins_sell/usd_to_harcoins;
        equity_harcoins[msg.sender] -= harcoins_sell;
        equity_usd[msg.sender] -= usd;
        total_harcoins_bought -= harcoins_sell;
    }

}
