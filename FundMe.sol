// SPDX-License-Identifier: MIT

pragma solidity >=0.6.6 < 0.9.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe {

    mapping(address => uint256) public addressToAmountFunded;

    function fund() public payable {
        addressToAmountFunded[msg.sender] += msg.value;
        // What is the eth to usd conversion rate.

        // How do we get the data of the conversion rate.
    }
}