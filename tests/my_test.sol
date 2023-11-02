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

    function testMatrixDefaultValue() public {
        int[5][10] memory matrix;
        int v = matrix[0][0];
        Assert.equal(v, 0, "Should be the default");
    }

    function testMatrixCopy() public {
        int[5][10] memory matrix1;
        int[5][10] memory matrix2;

        matrix1[0][0] = 1;
        matrix2[0] = matrix1[0];

        int v2 = matrix2[0][0];

        Assert.equal(v2, 1, "Should shallow copy");
    }
}