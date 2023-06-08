// SPDX-License-Identifier: MIT
// Selects the version of Solidity to use. 
pragma solidity ^0.8.0;

// Import the OpenZeppelin ERC721 standard contract to provide basic non-fungible token capabilities.
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

// This is the main Ticket contract. It inherits the properties and methods of ERC721.
contract Ticket is ERC721 {
    
    // Define a TicketModel struct to represent a ticket in the event. 
    struct TicketModel {
        uint eventId;      // The unique identifier of the event.
        uint seatNumber;   // The assigned seat number for this ticket.
        uint price;        // The price of the ticket.
    }

    uint public nextTokenId; // The token ID for the next ticket to be minted. Incremented after every mint.
    address public admin; // The admin's address, only this address has permission to mint tickets.

    // Mapping from token ID to TicketModel. Stores the details of each ticket.
    mapping(uint => TicketModel) public tickets;

    // An event that clients can listen for to get notified each time a ticket gets minted.
    event TicketMinted(uint tokenId, address to, uint eventId, uint seatNumber, uint price);

    // The constructor sets the initial admin address and the metadata for the token.
    constructor() ERC721("Ticket", "TICK") {
        admin = msg.sender; // The address deploying the contract is set as the admin.
    }

    // The mint function creates a new ticket and stores the data in the tickets mapping.
    // Only the admin can mint new tickets.
    function mint(address to, uint eventId, uint seatNumber, uint price) external {
        require(msg.sender == admin, "only admin"); // Only the admin can mint new tickets.
        // Create a new ticket.
        tickets[nextTokenId] = TicketModel({
            eventId: eventId,
            seatNumber: seatNumber,
            price: price    // price in ents
        });
        _mint(to, nextTokenId); // Mint the new token.

        // Emit the TicketMinted event.
        emit TicketMinted(nextTokenId, to, eventId, seatNumber, price);

        nextTokenId++; // Increment the tokenId for the next ticket.
    }

    // The getTicketDetails function returns the details of a specific ticket.
    // Requires that a token with the given ID exists.
    function getTicketDetails(uint tokenId) external view returns (uint, uint, uint) {
        require(_exists(tokenId), "token does not exist"); // Check if the token exists.
        TicketModel memory ticket = tickets[tokenId]; // Retrieve the ticket details.
        // Return the ticket details.
        return (ticket.eventId, ticket.seatNumber, ticket.price);
    }
}
