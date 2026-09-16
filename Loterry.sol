// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Lottery {

    address public manager;

    address payable[] public players;

    address payable public winner;

    constructor() {
        manager = msg.sender;
    }

    // Players enter the lottery by sending exactly 1 ETH
    function participate() public payable {
        require(
            msg.value == 1 ether,
            "Please pay 1 ether only"
        );

        players.push(payable(msg.sender));
    }

    // Only manager can check the contract balance
    function getBalance()
        public
        view
        returns (uint)
    {
        require(
            manager == msg.sender,
            "You are not the manager"
        );

        return address(this).balance;
    }

    // Generate a pseudo-random number
    function random()
        internal
        view
        returns (uint)
    {
        return uint(
            keccak256(
                abi.encodePacked(
                    block.prevrandao,
                    block.timestamp,
                    players.length
                )
            )
        );
    }

    // Pick a winner
    function pickWinner() public {

        require(
            msg.sender == manager,
            "Only manager can pick winner"
        );

        require(
            players.length >= 2,
            "At least 2 players required"
        );

        uint index = random() % players.length;

        winner = players[index];

        // Send entire balance to winner
        (bool success, ) = winner.call{
            value: address(this).balance
        }("");

        require(
            success,
            "Transfer failed"
        );

        // Reset players for the next lottery
        delete players;
    }

    // Get number of players
    function getPlayersCount()
        public
        view
        returns (uint)
    {
        return players.length;
    }
}