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

    function testDynamicVec() public {
        int[] memory vec1;
        int[] memory vec2;

        vec2 = vec1;
        vec1 = new int[](10);

        uint sizeVec2 = vec2.length;
        Assert.equal(sizeVec2, 0, "did not copy vec2");
        
        vec2 = vec1;
        uint sizeVec2N = vec2.length;
        Assert.equal(sizeVec2N, 10, "copied vec2");

        vec1[0] = 1;
        int vec2p0 = vec2[0];
        Assert.equal(vec2p0, 1, "shallow embedding");
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

    function testDynamicMatrix() public {
        int[][] memory matrix1;
        int[][] memory matrix2;

        matrix1 = new int[][](10);
        matrix2 = matrix1;

        uint v = matrix1.length;
        Assert.equal(v, 10, "matrix1 should initialize");

        matrix2[0] = new int[](2);
        matrix2[0][1] = 3;

        uint s10 = matrix1[0].length;
        Assert.equal(s10, 2, "matrix1 should shadow copy length");
    
        int v101 = matrix1[0][1];
        Assert.equal(v101, 3, "matrix1 should shadow copy value");
    }

    function testMatrixRowCopy() public {
        int[][5] memory matrix;

        matrix[0] = new int[](10);
        matrix[1] = matrix[0];

        uint s11 = matrix[1].length;
        Assert.equal(s11, 10, "should copy matrix");

        matrix[0][0] = 2;
        int m10 = matrix[1][0];
        Assert.equal(m10, 2, "should shallow copy the result");
    }

    int[5][10] SFMatrix1;
    int[5][10] SFMatrix2;

    function testStorageMatrix() public {
        int defaultValue = SFMatrix1[0][0];
        Assert.equal(defaultValue, 0, "storage matrix should have default value");

        SFMatrix1[0][0] = 1;

        SFMatrix2 = SFMatrix1;

        int s00 = SFMatrix2[0][0];
        Assert.equal(s00, 1, "should copy the value");

        SFMatrix1[0][1] = 2;
        int s01 = SFMatrix2[0][1];
        Assert.equal(s01, 0, "should deep copy");
    }

    int[][5] SFDMatrix1;
    int[][5] SFDMatrix2;

    function testStorageFixedMatrix() public {
        SFDMatrix1[0] = new int[](10);
        SFDMatrix2 = SFDMatrix1;

        SFDMatrix1[0][0] = 1;
        int s200 = SFDMatrix2[0][0];
        Assert.equal(s200, 0, "storage is just deep copy");

        SFDMatrix1[1] = SFDMatrix1[0];

        SFDMatrix1[0][1] = 2;
        int s111 = SFDMatrix1[1][1];
        Assert.equal(s111, 0, "storage is just deep copy");
    }

}