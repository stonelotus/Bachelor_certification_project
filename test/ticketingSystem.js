const TicketingSystem = artifacts.require('TicketingSystem');
const { assert } = require('chai');
const { expectRevert, expectEvent } = require('@openzeppelin/test-helpers');

contract('TicketingSystem', accounts => {
    let ticketingSystem = null;
    before(async () => {
        ticketingSystem = await TicketingSystem.new({ from: accounts[0] });
    });

    it('Should mint a new ticket bro', async () => {
        const tx = await ticketingSystem.mint("VIP Ticket", 1, 500, 1, 1657892544, { from: accounts[0] });
        expectEvent(tx, 'TicketMinted', { ticketId: '1' });

        const ticket = await ticketingSystem.getTicket(1);
        assert.equal(ticket.id.toString(), '1');
        assert.equal(ticket.name, 'VIP Ticket');
        assert.equal(ticket.price.toString(), '1');
        assert.equal(ticket.batch_size.toString(), '500');
        assert.equal(ticket.seats.toString(), '1');
        assert.equal(ticket.organizer, accounts[0]);
        assert.equal(ticket.date.toString(), '1657892544');
    });

    it('Should allow a user to buy a ticket', async () => {
        await ticketingSystem.buyTicket(1, { from: accounts[1], value: 1 });
        const newOwner = await ticketingSystem.ownerOf(1);
        assert.equal(newOwner, accounts[1]);
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
