# EMURGO FINAL PROJECT

## Table of Content

- [EMURGO FINAL PROJECT](#emurgo-final-project)
  - [Table of Content](#table-of-content)
  - [Description](#description)
  - [Requirements](#requirements)
  - [Functionalities](#functionalities)
    - [Create Event Ticket (addEvent)](#create-event-ticket-addevent)
    - [Get Event Ticket Detail (getEvent)](#get-event-ticket-detail-getevent)
    - [Update Event Ticket Detail (updateEvent)](#update-event-ticket-detail-updateevent)
    - [Delete Event Ticket Detail (deleteEvent)](#delete-event-ticket-detail-deleteevent)
    - [Buy Event Ticket (buyEvent)](#buy-event-ticket-buyevent)
  - [Contribution](#contribution)
  - [License](#license)

## Description

This project allows user to buy and get an event ticket and owner (the deployer) to create, get, update, and delete an event.

## Requirements

* Remix IDE or VSCode with Remix Extension. 
* Solidity language extension if you're using VSCode.

## Functionalities

### Create Event Ticket (addEvent)

Only Owner (the address that deploys the contract) can use this function. This function allows the Owner to create an Event ticket detail (address, name, location, stock, and price). You can use an address from the Remix account list. The Event ticket will be mapped to an address for identifying purpose. Requires stock and price to be filled with value more than 0.

### Get Event Ticket Detail (getEvent)

Any address can use this function. Find a ticket by its address and returns the details of that event.

### Update Event Ticket Detail (updateEvent)

Only Owner (the address that deploys the contract) can use this function. This function allows the Owner to update an Event ticket detail (address, name, location, stock, and price). Requires stock and price to be filled with value more than 0.

### Delete Event Ticket Detail (deleteEvent)

Only Owner (the address that deploys the contract) can use this function. This function allows the Owner to delete an Event ticket. 

### Buy Event Ticket (buyEvent)

Addresses other than Owner can use this function. This function allows users to buy an Event ticket and its amount as long as the ticket stock is still available, has more stock than the demanded amount, and the user's wallet value is more than the ticket's price.

## Contribution

Anyone is allowed to open an Issue if there is something wrong or want to ask something or create a PR to improve/add something.

## License
See LICENSE file.