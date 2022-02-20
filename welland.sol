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
    
    struct Product {
        string productName;
        uint256 cost;
        address productOwner;
        bool rewardPartner;
    }
    address partner = address(0xB022BCc9D4c2Ea965b13f2bFAE760585f65eBF29);
    Product[] public products;
    string[] public productNames;

    function registerProduct(string memory productName, uint256 productCost, bool partnerRewards) public {
        products.push(Product(productName, productCost, msg.sender, partnerRewards));
        productNames.push(productName);
    }

    function viewProducts() public view returns (Product[] memory)  {
        return products;
    }

    function viewProductNames() public view returns (string[] memory)  {
        return productNames;
    }

    function purchaseProduct(uint productCode) public payable {
        require(getConversionRate(msg.value) > products[productCode].cost * 10**18);
        
        Product storage product = products[productCode];
        if (product.rewardPartner) {
            uint256 reward = uint256(msg.value / 50);
            uint256 remaining = msg.value - reward;
            payable(product.productOwner).transfer(remaining);
            payable(partner).transfer(reward);
        } else {
            payable(product.productOwner).transfer(msg.value);
        }
    }

    // function checkRate(uint256 value) public {
    //     return getConversionRate(value);
    // }

    function getPrice() public view returns (uint256) {
        (,int256 answer,,,) = priceFeed.latestRoundData();
    return uint256(answer * 10**10);
    }

    function getVersion() public view returns (uint256) {
        return priceFeed.version();
    }

    function getConversionRate(uint256 ethAmount) public view returns (uint256){
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1000000000000000000;
        // the actual ETH/USD conversation rate, after adjusting the extra 0s.
        return ethAmountInUsd;
    }
}