// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;
import "./PriceConverter.sol";

contract FundMe{
    using PriceConverter for uint256;

    uint256 public minimumUsd=50 * 1e18; //the msg.value is in Wei
    address[] public funders;
    mapping(address => uint256) public addressToAmount;

    function fund() public payable {
        require(msg.value.getConversionRate() >= minimumUsd, "not enough");
        funders.push(msg.sender);
        addressToAmount[msg.sender] = msg.value;
    }

    // function withdraw(){}
}