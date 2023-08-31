// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
import "remix_tests.sol"; // this import is automatically injected by Remix.
import "hardhat/console.sol";
import "../contracts/storage.sol";

contract BallotTest {

    Storage st;

    function testStorage() public {
        st = new Storage();
        (int v1 , int v2) = st.usingStorage();
        Assert.equal(v1, 0, "v1 should be deep copied");
        Assert.equal(v2, 2, "v2 should be deep copied");
    }

    function testArray() public {
        st = new Storage();
        int v1 = st.isShallow(1);
        Assert.equal(v1, 1, "v1 should be a shallow copied");
    }
}