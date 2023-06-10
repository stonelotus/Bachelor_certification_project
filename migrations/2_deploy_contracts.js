
const HelloWorld = artifacts.require("HelloWorld");
const TicketingSystem = artifacts.require("TicketingSystem");

module.exports = function (deployer) {
  deployer.deploy(HelloWorld);
  deployer.deploy(TicketingSystem);
};