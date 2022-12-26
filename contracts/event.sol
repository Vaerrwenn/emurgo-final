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

    // Address mapped to eventStruct for unique identifier.
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

    function updateEvent(
        address eventAddr, 
        string memory name,
        string memory location,
        uint stock,
        uint price) public onlyOwner
    returns (address eventAddress, string memory eventName, string memory eventLoc, uint eventStock, uint eventPrice, string memory status) {
        require(stock > 0, "Event stock must be more than 0");

        require(price > 0, "Event price must be more than 0");

        // Needs to be "storage" for it to be able to be updated.
        eventStruct storage eventD;

        eventD = eventData[eventAddr];
        eventD.name = name;
        eventD.location = location;
        eventD.stock = stock;
        eventD.price = price;

        eventAddress = eventAddr;
        eventName = eventD.name;
        eventLoc = eventD.location;
        eventStock = eventD.stock;
        eventPrice = eventD.price;
        status = "Updated.";
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

    // getEvent gets an event detail by using event's address.
    function getEvent(address eventAddr) public view 
    returns (address eventAddress, string memory eventName, string memory eventLoc, uint eventStock, uint eventPrice) {
        eventAddress = eventAddr;
        eventName = eventData[eventAddr].name;
        eventLoc = eventData[eventAddr].location;
        eventStock = eventData[eventAddr].stock;
        eventPrice = eventData[eventAddr].price;
    }

    // buyEvent allows user to buy an event ticket. It'll deduct the event's ticket stock by amount and have payable feature.
    function buyEvent(address eventAddr, uint amount) public payable
    returns (address eventAddress, string memory eventName, string memory eventLoc, uint eventStock, uint eventPrice, string memory status) {
        require(amount > 0, "Invalid event amount.");

        require(msg.sender != ownerAddress, "Owner can not buy any Event.");

        eventStock = eventData[eventAddr].stock;

        require(eventStock > 0, "Event is not available.");

        require(amount < eventStock, "Amount exceed event's availability.");

        eventAddress = eventAddr;
        eventName = eventData[eventAddr].name;
        eventLoc = eventData[eventAddr].location;
        eventData[eventAddr].stock = eventData[eventAddr].stock - amount;
        eventStock = eventData[eventAddr].stock;

        require(msg.value >= eventPrice * amount, "You don't have the sufficient money.");
        payable(address(this)).transfer(msg.value);
        
        status = "Success";
    }
}