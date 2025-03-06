pragma solidity ^0.5.10;

library Verification {
    function Assert  (bool b) public;
    function Assume  (bool b) public;
    function CexPrinti  (uint i) public;
}

contract Simple {
    struct Account {
        int balance;
    }

    struct Person {
        int age;
        bool isMale;
        Account account;
    }

    Person alice;
    Person ana;
    Person carol;
    Person[] family;

    int[] vInt1;
    int[] vInt2;

    mapping (address => uint) balances;

    function testCanCopyStorage() public {
        carol.age = 20;
        ana = carol;
        Verification.Assert(ana.age == 20);
    }

    int[] ages;

    function testUsingArrayStorage() public {
        require(ages.length == 0);

        ages.push(0);
        ages.push(1);

        int arrayValue = ages[1];
        Verification.Assert(arrayValue == 1);
    }

    function testStorage() public {
        require(family.length == 0);
        alice.age = 0;
        int aliceAgeBefore = alice.age;
        Verification.Assert(aliceAgeBefore == 0);

        family.push(alice);
        alice.age = 20;
        int aliceAge = family[0].age;
        Verification.Assert(aliceAge == 0);
    }

    function testMatrixDefaultValue() public {
        int[5][10] memory matrix;
        int v = matrix[0][0];
        Verification.Assert(v == 0);
    }

    function testMatrixCopy() public {
        int[5][10] memory matrix1;
        int[5][10] memory matrix2;

        matrix1[0][0] = 1;
        matrix2[0] = matrix1[0];

        int v200 = matrix2[0][0];

        Verification.Assert(v200 == 1);
    }

    function testDynamicMatrix() public {
        int[][] memory matrix1;
        int[][] memory matrix2;

        matrix1 = new int[][](10);
        matrix2 = matrix1;

        uint v = matrix1.length;
        Verification.Assert(v == 10);

        matrix2[0] = new int[](2);
        matrix2[0][1] = 3;

        uint s10 = matrix1[0].length;
        Verification.Assert(s10 == 2);

        int v101 = matrix1[0][1];
        Verification.Assert(v101 == 3);
    }

    function testMatrixRowCopy() public {
        int[][5] memory matrix;

        matrix[0] = new int[](10);
        matrix[1] = matrix[0];

        uint s11 = matrix[1].length;
        Verification.Assert(s11 == 10);

        matrix[0][0] = 2;
        int m10 = matrix[1][0];
        Verification.Assert(m10 == 2);
    }

    int[5][10] SFMatrix1;
    int[5][10] SFMatrix2;

    function testStorageMatrix() public {
        SFMatrix1[0][0] = 1;

        SFMatrix2 = SFMatrix1;

        int s00 = SFMatrix2[0][0];
        Verification.Assert(s00 == 1);
    }
}
