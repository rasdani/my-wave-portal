// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

import "hardhat/console.sol";

contract WavePortal {
  uint256 totalWaves;
  uint256 count;
  mapping(address => uint) public counts;

  constructor() {
    console.log("Yo yo, I am a contract and I am smart");
  }

  function wave() public {
    counts[msg.sender] += 1;
    totalWaves += 1;
    console.log("%s has waved!", msg.sender);
  }

  function getTotalWaves() public view returns (uint256) {
    console.log("We have %d total waves!", totalWaves);
    return totalWaves;
  }

  /*function incrementCount() public {*/
   /*counts[msg.sender] += 1;*/
  /*}*/

  function getCount() public view returns (uint) {
    console.log("Here are the wave counts for %s:", msg.sender, counts[msg.sender]);
    return counts[msg.sender];
  }
}
