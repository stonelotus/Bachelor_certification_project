// SPDX-License-Identifier: MIT
// Selects the version of Solidity to use.
pragma solidity ^0.8.0;

import "../node_modules/@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract TicketingSystem is ERC721Enumerable {
    uint256 private ticketId; // Keeps track of the total number of tickets

    // Structure to hold ticket data
    struct Ticket {
        uint256 id; // Unique ticket id
        string name; // Name of the ticket
        uint256 price; // Price of the ticket
        uint256 batch_size; // The batch size of the tickets
        uint256 seats; // Number of seats per ticket
        address organizer; // Address of the organizer who created the ticket
        uint256 date; // Date of the event
    }

    // Mapping from ticket id to Ticket struct
    mapping(uint256 => Ticket) public tickets;

    event TicketMinted(uint256 ticketId);

    constructor() ERC721("TicketingSystem", "TICKET") {}

    // Function to mint a new ticket. Any user can call this function.
    function mint(
        string memory name,
        uint256 price,
        uint256 batch_size,
        uint256 seats,
        uint256 date
    ) public {
        ticketId++;
        tickets[ticketId] = Ticket(
            ticketId,
            name,
            price,
            batch_size,
            seats,
            msg.sender,
            date
        );
        _mint(msg.sender, ticketId); // Create the NFT for the ticket
        emit TicketMinted(ticketId);
    }

    // Function to buy a ticket. The user who calls this function will be the new owner of the ticket.
    function buyTicket(uint256 _ticketId) public payable {
        require(_exists(_ticketId), "Error: ticket does not exist");
        Ticket storage ticket = tickets[_ticketId];
        require(msg.value >= ticket.price, "Error: insufficient funds");
        address owner = ownerOf(_ticketId);
        require(owner != msg.sender, "Error: cannot buy your own ticket");

        _transfer(owner, msg.sender, _ticketId); // Transfer the ownership of the ticket to the buyer
        // Send the funds to the owner of the ticket.
        payable(owner).transfer(msg.value);  //should be msg.value
    }
    // This function will return the owner of a given ticket.
    function getOwner(uint256 _ticketId) public view returns (address) {
        return ownerOf(_ticketId);
    }

    // Function to get the details of a ticket.
    function getTicket(
        uint256 _ticketId
    )
        public
        view
        returns (
            uint256 id,
            string memory name,
            uint256 price,
            uint256 batch_size,
            uint256 seats,
            address organizer,
            uint256 date
        )
    {
        require(_exists(_ticketId), "Error: ticket does not exist");
        Ticket storage ticket = tickets[_ticketId];
        return (
            ticket.id,
            ticket.name,
            ticket.price,
            ticket.batch_size,
            ticket.seats,
            ticket.organizer,
            ticket.date
        );
    }
}
