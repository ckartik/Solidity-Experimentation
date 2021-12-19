// SPDX-License-Identifier: MIT

pragma solidity >=0.6.0 < 0.9.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe {
    
    AggregatorV3Interface internal priceFeed;

    constructor() {
        priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
    }

    mapping(address => uint256) public addressToAmountFunded;

    function fund() public payable {
        addressToAmountFunded[msg.sender] += msg.value;
        // What is the eth to usd conversion rate.
        // How do we get the data of the conversion rate.
    }

    function getPrice() public view returns (uint256) {
        (uint80 roundId,
        int256 answer,
        uint256 startedAt,
        uint256 updatedAt,
        uint80 answeredInRound
    ) = priceFeed.latestRoundData();
    return uint256(answer);
    }
    function getVersion() public view returns (uint256) {
        return priceFeed.version();
    }
}