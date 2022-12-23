// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

import "hardhat/console.sol";

contract WavePortal {
  uint256 totalWaves;
  mapping(address => uint256) public waveBalances;

  event NewWave(address indexed from, uint256 timestamp, string message);

  struct Wave {
    address waver;
    string message;
    uint256 timestamp;
  }

  Wave[] waves;

  constructor() payable {
    console.log("Contract constructed!");
  }

  function wave(string memory _message) public {
    waveBalances[msg.sender] += 1;
    totalWaves += 1;
    console.log("%s has waved: %s", msg.sender, _message);

    waves.push(Wave(msg.sender, _message, block.timestamp));

    emit NewWave(msg.sender, block.timestamp, _message);

    uint256 prizeAmount = 0.0001 ether;
    require(
      prizeAmount <= address(this).balance,
      "Trying to withdraw more money than the contract has."
    );

    (bool succes, ) = (msg.sender).call{value: prizeAmount}("");
    require(succes, "Failed to withdraw money from contract.");
  }

  function getAllWaves() public view returns (Wave[] memory) {
    return waves;
  }

  function getTotalWaves() public view returns (uint256) {
    console.log("We have %d total waves!", totalWaves);
    return totalWaves;
  }

  function getUserBalance() public view returns (uint256) {
    console.log("Here are the wave counts for %s:", msg.sender, waveBalances[msg.sender]);
    return waveBalances[msg.sender];
  }
}
