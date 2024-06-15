// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;
import "./PriceConverter.sol";

//751908
//731994 constant
contract FundMe{
    using PriceConverter for uint256;

    uint256 public constant minimumUsd=50 * 1e18; //the msg.value is in Wei
    //saving gas using 'constant'
    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;
    address public immutable i_owner;

    //constant and immutable can save gas by store the data in contract's bytecode 
    //instead of storage slot

    constructor(){
        i_owner=msg.sender;
    }
    function fund() public payable {
        require(msg.value.getConversionRate() >= minimumUsd, "not enough");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw() public onlyOwner{
        
        for(uint256 i = 0; i < funders.length;i ++){
            address funder = funders[i];
            addressToAmountFunded[funder] = 0;
        }
        // as a storage array, even reset to length 0, it can be modified by 'push'/'pop'
        //if it is a memory array, once it reset to length 0, you can not add element to it.
        funders=new address[](0);
 
        //1. transfer, auto revert
        //payable (msg.sender).transfer(address(this).balance);

        //2. send, need 'require' to manually revert
        //bool success = payable (msg.sender).send(address(this).balance);
        //require(success,'send fail');
        
        //3. call, recommanded 
        (bool callSuccess, ) = payable (msg.sender).call{value : address(this).balance}("");
        require(callSuccess,'send fail');
    }
    modifier onlyOwner{
        require(msg.sender==i_owner, "sender is not owner!");
        _;
    }

    receive() external payable { fund();}
    fallback() external payable { fund();}
}