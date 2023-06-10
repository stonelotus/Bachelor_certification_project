const TicketingSystem = artifacts.require('TicketingSystem');
const { assert } = require('chai');
const { expectRevert, expectEvent } = require('@openzeppelin/test-helpers');

contract('TicketingSystem', accounts => {
    let ticketingSystem = null;
    before(async () => {
        ticketingSystem = await TicketingSystem.deployed();
    });

    it('Should mint a new ticket', async () => {
        await ticketingSystem.mint("VIP Ticket", 1, 500, 1, 1657892544, { from: accounts[0] });
        const ticket = await ticketingSystem.getTicket(1);
        assert(ticket.name === 'VIP Ticket');
        assert(ticket.price.toNumber() === 1);
        assert(ticket.batch_size.toNumber() === 500);
        assert(ticket.seats.toNumber() === 1);
        assert(ticket.organizer === accounts[0]);
        assert(ticket.date.toNumber() === 1657892544);
    });

    it('Should allow a user to buy a ticket', async () => {
        await ticketingSystem.buyTicket(1, { from: accounts[1], value: 1 });
        const newOwner = await ticketingSystem.ownerOf(1);
        assert(newOwner === accounts[1]);
    });

    it('Should fail if user tries to buy a non-existent ticket', async () => {
        await expectRevert(
            ticketingSystem.buyTicket(999, { from: accounts[1], value: 1 }),
            'Error: ticket does not exist',
        );
    });

    it('Should fail if user tries to buy their own ticket', async () => {
        await expectRevert(
            ticketingSystem.buyTicket(1, { from: accounts[1], value: 1 }),
            'Error: cannot buy your own ticket',
        );
    });

    it('Should fail if user tries to buy a ticket with insufficient funds', async () => {
        await expectRevert(
            ticketingSystem.buyTicket(1, { from: accounts[0], value: 0 }),
            'Error: insufficient funds',
        );
    });
});
