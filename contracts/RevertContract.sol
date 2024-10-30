// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract RevertContract {
  constructor() public {
  }

  function testRevertFirst() public pure {
    assert(false);
  }

  uint[][] s;

  function testRevertRemoveMatrixNoPath() public {
    delete s;

    s.push();
    s[0].push(41);
    s.pop();
    s[0].push(42);
  }

  int[] v;

  function testRevertAddToArray() public {
    delete v;

    v.push(0x41);
    v.pop();
    int u = v[0];
  }
}
