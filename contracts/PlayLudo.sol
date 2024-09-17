// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract PlayLudo {
    struct Player {
        uint position;
        bool wonGame;
    }

    mapping(address => Player) public players;
    uint public boardSize = 56;
    uint public maxPlayers = 4;
    address[] public playerAddresses;

  
    function joinGame() public {
        require(playerAddresses.length < maxPlayers, "Max players reached");
        require(
            players[msg.sender].position == 0,
            "You are already in the game"
        );

        players[msg.sender] = Player(1, false);
        playerAddresses.push(msg.sender);
    }

    
    function diceRoll() public returns (uint) {
        require(players[msg.sender].position > 0, "You are not in the game!");
        require(!players[msg.sender].wonGame, "You already won!");

        uint rollDice = (random() % 6) + 1;

       
        players[msg.sender].position += rollDice;

        if (players[msg.sender].position >= boardSize) {
            players[msg.sender].wonGame = true;
            players[msg.sender].position = boardSize;
        }

        return rollDice;
    }

   
    function random() internal view returns (uint) {
        return
            uint(
                keccak256(
                    abi.encodePacked(
                        block.timestamp,
                        msg.sender,
                        block.prevrandao
                    )
                )
            );
    }

    
    function checkWinner() public view returns (address) {
        for (uint i = 0; i < playerAddresses.length; i++) {
            if (players[playerAddresses[i]].wonGame) {
                return playerAddresses[i];
            }
        }
        return address(0);
    }
}
