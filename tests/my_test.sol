// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
import "remix_tests.sol"; // this import is automatically injected by Remix.
import "hardhat/console.sol";
import "../contracts/storage.sol";

contract BallotTest {

    function testStorage() public {
        Storage st = new Storage();
        (int v1 , int v2) = st.usingStorage();
        Assert.equal(v1, 0, "v1 should be deep copied");
        Assert.equal(v2, 2, "v2 should be deep copied");
    }

    function testArray() public {
        Storage st = new Storage();
        int v1 = st.isShallow(1);
        Assert.equal(v1, 1, "v1 should be a shallow copied");
    }

    function testShallowStruct() public {
        Storage st = new Storage();
        int v1 = st.copyingStructLocally(1);
        Assert.equal(v1, 1, "v1 should be shallowed copied");
    }

    function testUsingArrayStorage() public {
        Storage st = new Storage();
        st.usingArrayStorage();
        Assert.equal(st.getArrayLenght(), 2, "Should added two values");
        int arrayValue = st.getArray(1);
        Assert.equal(arrayValue, 1, "Should allow to write");
    }
}