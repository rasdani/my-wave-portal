// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

import "hardhat/console.sol";

contract WavePortal {
  uint256 totalWaves;
  uint256 count;
  mapping(address => uint256) public counts;

  event NewWave(address indexed from, uint256 timestamp, string message);

  struct Wave {
    address waver;
    string message;
    uint256 timestamp;
  }

  Wave[] waves;

  constructor() {
    console.log("Yo yo, I am a contract and I am smart");
  }

  function wave(string memory _message) public {
    counts[msg.sender] += 1;
    totalWaves += 1;
    console.log("%s has waved: %s", msg.sender, _message);

    waves.push(Wave(msg.sender, _message, block.timestamp));
    emit NewWave(msg.sender, block.timestamp, _message);
  }

  function getAllWaves() public view returns (Wave[] memory) {
    return waves;
  }

  function getTotalWaves() public view returns (uint256) {
    console.log("We have %d total waves!", totalWaves);
    return totalWaves;
  }

  /*function incrementCount() public {*/
   /*counts[msg.sender] += 1;*/
  /*}*/

  function getWaveCount() public view returns (uint256) {
    /*console.log("Here are the wave counts for %s:", msg.sender, counts[msg.sender]);*/
    return counts[msg.sender];
  }
}
