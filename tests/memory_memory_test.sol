// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
import "remix_tests.sol"; // this import is automatically injected by Remix.
import "hardhat/console.sol";
import "../contracts/storage.sol";

contract MemoryMemoryTest {
   Caller private obj;
   
   constructor() {
      obj = new Caller();
   }

    function testCallOtherContract() public {
        uint x = obj.call();
        Assert.equal(x, 0, "Should erase shallow copy");
    }
}