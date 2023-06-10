// SPDX-License-Identifier: MIT
// Selects the version of Solidity to use.
pragma solidity ^0.8.0;

contract HelloWorld {
    string public yourName;

    constructor() public {
        yourName = "Unknown";
    }

    function setName(string memory nm) public {
        yourName = nm;
    }
}
