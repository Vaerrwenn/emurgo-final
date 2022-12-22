// // SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EventContract {

    constructor() {
        ownerAddress = msg.sender;
    }

    receive() external payable{}

    address public ownerAddress; 

    struct eventStruct {
        string name;
        string location;
        uint stock;
        uint price;
    } 

    mapping(address => eventStruct) eventData;

    address[] public addrList;

    modifier onlyOwner {
        require(msg.sender == ownerAddress, "Only owner can access this!");
        _;
    }

    function addEvent(
        address eventAddr,
        string memory eventName, 
        string memory eventLocation, 
        uint eventStock, 
        uint eventPrice
    ) public onlyOwner
    {
        require(eventStock > 0, "Event stock must be more than 0");
        require(eventPrice > 0, "Event price must be more than 0");

        eventData[eventAddr].name = eventName;
        eventData[eventAddr].location = eventLocation;
        eventData[eventAddr].stock = eventStock;
        eventData[eventAddr].price = eventPrice;

        addrList.push(eventAddr);
    }

    function getEvent(address eventAddr) public view 
    returns (address EventAddr, string memory EventName, string memory EventLoc, uint EventStock, uint EventPrice) {
        EventAddr = eventAddr;
        EventName = eventData[eventAddr].name;
        EventLoc = eventData[eventAddr].location;
        EventStock = eventData[eventAddr].stock;
        EventPrice = eventData[eventAddr].price;
    }

    function deleteEvent(address eventAddr) public onlyOwner {

        delete eventData[eventAddr];

        uint totalEvents = addrList.length;
        uint j = 0;
        uint index;

        while(j < totalEvents) {
            if(addrList[j] == eventAddr) {
                index = j;

                break;
            }
            j++;
        }

        for (uint i = index; i < addrList.length-1; i++){
            addrList[i] = addrList[i+1];
        }

        addrList.pop();
    }

    // TODO: add BuyEvent
}