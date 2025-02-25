// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
// import "../contracts/Storage.sol";

contract Simple {
    struct Account {
        int balance;
    }

    struct Person {
        int age;
        bool isMale;
        string[10] friends;
        Account account;
    }

    Person alice;
    Person ana;
    Person carol;
    Person[] family;

    int[] vInt1;
    int[] vInt2;

    mapping (address => uint) public balances;

    function testCanCopyStorage() public {
        carol.age = 20;
        ana = carol;
        assert(ana.age == 20);
    }

    int[] public ages;

    function testUsingArrayStorage() public {
        delete ages;

        ages.push(0);
        ages.push(1);

        uint agesLength = ages.length;
        assert(agesLength == 2);
        int arrayValue = ages[1];
        assert(arrayValue == 1);
    }
    function testMatrixDefaultValue() public {
        int[5][10] memory matrix;
        int v = matrix[0][0];
        assert(v == 0);
    }

    function testMatrixCopy() public {
        int[5][10] memory matrix1;
        int[5][10] memory matrix2;

        matrix1[0][0] = 1;
        matrix2[0] = matrix1[0];

        int v200 = matrix2[0][0];

        assert(v200 == 1);
    }

    function testDynamicMatrix() public {
        int[][] memory matrix1;
        int[][] memory matrix2;

        matrix1 = new int[][](10);
        matrix2 = matrix1;

        uint v = matrix1.length;
        assert(v == 10);

        matrix2[0] = new int[](2);
        matrix2[0][1] = 3;

        uint s10 = matrix1[0].length;
        assert(s10 == 2);

        int v101 = matrix1[0][1];
        assert(v101 == 3);
    }

    function testMatrixRowCopy() public {
        int[][5] memory matrix;

        matrix[0] = new int[](10);
        matrix[1] = matrix[0];

        uint s11 = matrix[1].length;
        assert(s11 == 10);

        matrix[0][0] = 2;
        int m10 = matrix[1][0];
        assert(m10 == 2);
    }

    int[5][10] SFMatrix1;
    int[5][10] SFMatrix2;

    function testStorageMatrix() public {
        int defaultValue = SFMatrix1[0][0];
        assert(defaultValue == 0);

        SFMatrix1[0][0] = 1;

        SFMatrix2 = SFMatrix1;

        int s00 = SFMatrix2[0][0];
        assert(s00 == 1);

        SFMatrix1[0][1] = 2;
        int s01 = SFMatrix2[0][1];
        assert(s01 == 0);
    }

    int[][5] SFDMatrix1;
    int[][5] SFDMatrix2;

    function testStorageFixedMatrix() public {
        SFDMatrix1[0] = new int[](10);
        SFDMatrix2 = SFDMatrix1;

        SFDMatrix1[0][0] = 1;
        int s200 = SFDMatrix2[0][0];
        assert(s200 == 0);

        SFDMatrix1[1] = SFDMatrix1[0];

        SFDMatrix1[0][1] = 2;
        int s111 = SFDMatrix1[1][1];
        assert(s111 == 0);
    }
}
