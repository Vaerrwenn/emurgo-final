// // SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EventContract {
    address public ownerAddress; 

    struct eventStruct {
        uint id;
        string name;
        string location;
        uint stock;
        uint price;
    }

    struct user {
        uint id;
        string name;
    }

    eventStruct[] public events;

    constructor() {
        ownerAddress = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == ownerAddress, "Only owner can access this!");
        _;
    }

    receive() external payable{}

    function addEvent(string memory eventName, string memory eventLocation, uint eventStock, uint eventPrice) public pure
    {
        
        require(eventStock > 0, "Event stock must be more than 0");
        require(eventPrice > 0, "Event price must be more than 0");
    }
}