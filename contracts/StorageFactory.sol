// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;
import "./SimpleStorage.sol";

contract StorageFactory {

    SimpleStorage[] public simpleStorageArray;
    function createSimpleStorageContract() public {
        // simpleStorage = new SimpleStorage();
        simpleStorageArray.push(new SimpleStorage());
    }

    function sfStore(uint256 _simpleStorageIndex, uint256 _sfNumber) public{
        SimpleStorage simpleStorage=simpleStorageArray[_simpleStorageIndex];
        simpleStorage.store(_sfNumber);
    }
    function sfGet(uint256 _simpleStorageIndex) public view returns (uint256) {
        SimpleStorage simpleStorage=simpleStorageArray[_simpleStorageIndex];
        return simpleStorage.retrieve();
    }
}  