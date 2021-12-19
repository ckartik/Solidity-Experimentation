// SPDX-License-Identifier: MIT

pragma solidity >=0.6.0 <0.9.0;

import "./SimpleStorage.sol";

contract StorageFactory {

    SimpleStorage[] public simpleStorageArray;

    function createSimpleStorageContract() public {
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
    }

    function retrieve(uint256 _index) public view returns (uint256) {
        return simpleStorageArray[_index].retrieve();
    }

    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public {
        // To Interact with a contract 
        // You need the Address, and ABI (Application Binary Interface).

        address contractAdr = address(simpleStorageArray[_simpleStorageIndex]);
        SimpleStorage ss = SimpleStorage(contractAdr);
        ss.store(_simpleStorageNumber);
    }
}