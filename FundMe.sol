// SPDX-License-Identifier: MIT

pragma solidity >=0.6.0 < 0.9.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract WellandShop {
    
    AggregatorV3Interface internal priceFeed;
    address public owner;

    constructor() {
        owner = msg.sender;
        // priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        // Kovan Network price feed
        priceFeed = AggregatorV3Interface(0x9326BFA02ADD2366b30bacB125260Af641031331);
    }

    mapping(address => uint256) public addressToAmountFunded;
    mapping(uint256 => address) public productCreators;
    mapping(uint256 => ufixed) public productCost;
    address[] public funders;

    function registerProduct(string productName, ufixed productCost) public {
        
    }

    function purchaseProduct(uint256 productCode) public payable {
        // Get Conversion Rate.
        // Move assets to user.
    }

    function fund() public payable {
        uint256 minimumUSD = 5 * 10 ** 18;
        require(minimumUSD <= getConversionRate(msg.value), "You need more eth");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
        // What is the eth to usd conversion rate.
        // How do we get the data of the conversion rate.
    }

    function getPrice() public view returns (uint256) {
        (,int256 answer,,,) = priceFeed.latestRoundData();
    return uint256(answer * 10**10);
    }

    function getVersion() public view returns (uint256) {
        return priceFeed.version();
    }

    function getConversionRate(uint256 ethAmount) public view returns (uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / (10**18);
        return ethAmountInUsd;
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    function withdraw() payable onlyOwner public {
        payable(msg.sender).transfer(address(this).balance);
        for (uint256 i = 0; i < funders.length;  i++){
            address funderAdrs = funders[i];
            addressToAmountFunded[funderAdrs] = 0;
        }
        funders = new address[](0);
    }
}