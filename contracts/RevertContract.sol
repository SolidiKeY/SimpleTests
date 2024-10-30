// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract RevertContract {
  constructor() public {
  }

  function shouldRevert() public pure {
    assert(false);
  }
}
