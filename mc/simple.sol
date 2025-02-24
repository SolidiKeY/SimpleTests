// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
import "../contracts/Storage.sol";

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

    // Person alice;
    Person ana;
    Person carol;
    Person[] family;

    int[] vInt1;
    int[] vInt2;

    mapping (address => uint) public balances;

    function testMemory() public {
        Person memory alice;
        Person memory bob;

        alice.account.balance = 10;
        bob.account.balance = 20;
        Account memory acc = bob.account;

        alice.account = bob.account;
        assert(acc.balance == 20);

        acc.balance = 30;
        assert(alice.account.balance == 30);
        assert(bob.account.balance == 30);
    }

    // function testStorage() public {
    //     int aliceAgeBefore = alice.age;
    //     assert(aliceAgeBefore == 0);
    //     family.push(alice);
    //     alice.age = 20;
    //     int aliceAge = family[0].age;
    //     assert(aliceAge == 0);

    //     Person memory bob;
    //     bob.age = 40;
    //     family.push(bob);
    //     bob.age = 41;
    //     int bobAge = family[1].age;
    //     assert(bobAge == 40);
    // }

    // function testCanCopyStorage() public {
    //     carol.age = 20;
    //     ana = carol;
    //     assert(ana.age == 20);
    // }

    // function testCanCompare() public {
    //     // bool aliceEqAna = alice == ana;
    //     // Can not compare structure in storage

    //     // bool sameArray = vInt1 == vInt2;
    //     // Can not compare arrays in storage

    //     Person memory pMemory1;
    //     Person memory pMemory2;

    //     // bool sameMemory = pMemory1 == pMemory2;
    //     // Can not compare structures in memory

    //     int[] memory v1;
    //     int[] memory v2;

    //     // bool v1EqV2 = v1 == v2;
    //     // Can not compare arrays in memory
    // }

    // function testArray() public {
    //     Person[] memory friends = new Person[](10);
    //     friends[1] = friends[0];
    //     friends[0].age = 20;

    //     int friendAge1 = friends[1].age;
    //     assert(friendAge1 == 20);
    // }

    // function testShallowStruct() public {
    //     Person memory eve;
    //     Person memory carol;

    //     carol = eve;
    //     eve.age = 20;

    //     int v1 = carol.age;
    //     assert(v1 == 20);
    // }

    // int[] public ages;

    // function testUsingArrayStorage() public {
    //     ages.push(0);
    //     ages.push(1);

    //     uint agesLength = ages.length;
    //     assert(agesLength == 2);
    //     int arrayValue = ages[1];
    //     assert(arrayValue == 1);
    // }

    // function testDynamicVec() public {
    //     int[] memory yearsVec;
    //     int[] memory numbers;

    //     numbers = yearsVec;
    //     yearsVec = new int[](10);

    //     uint numbersSize = numbers.length;
    //     assert(numbersSize == 0);

    //     numbers = yearsVec;
    //     numbersSize = numbers.length;
    //     assert(numbersSize == 10);

    //     yearsVec[0] = 1;
    //     int numbers0 = numbers[0];
    //     assert(numbers0 == 1);
    // }

    // function testMatrixDefaultValue() public {
    //     int[5][10] memory matrix;
    //     int v = matrix[0][0];
    //     assert(v == 0);
    // }

    // function testMatrixCopy() public {
    //     int[5][10] memory matrix1;
    //     int[5][10] memory matrix2;

    //     matrix1[0][0] = 1;
    //     matrix2[0] = matrix1[0];

    //     int v200 = matrix2[0][0];

    //     assert(v200 == 1);
    // }

    // function testDynamicMatrix() public {
    //     int[][] memory matrix1;
    //     int[][] memory matrix2;

    //     matrix1 = new int[][](10);
    //     matrix2 = matrix1;

    //     uint v = matrix1.length;
    //     assert(v == 10);

    //     matrix2[0] = new int[](2);
    //     matrix2[0][1] = 3;

    //     uint s10 = matrix1[0].length;
    //     assert(s10 == 2);

    //     int v101 = matrix1[0][1];
    //     assert(v101 == 3);
    // }

    // function testMatrixRowCopy() public {
    //     int[][5] memory matrix;

    //     matrix[0] = new int[](10);
    //     matrix[1] = matrix[0];

    //     uint s11 = matrix[1].length;
    //     assert(s11 == 10);

    //     matrix[0][0] = 2;
    //     int m10 = matrix[1][0];
    //     assert(m10 == 2);
    // }

    // int[5][10] SFMatrix1;
    // int[5][10] SFMatrix2;

    // function testStorageMatrix() public {
    //     int defaultValue = SFMatrix1[0][0];
    //     assert(defaultValue == 0);

    //     SFMatrix1[0][0] = 1;

    //     SFMatrix2 = SFMatrix1;

    //     int s00 = SFMatrix2[0][0];
    //     assert(s00 == 1);

    //     SFMatrix1[0][1] = 2;
    //     int s01 = SFMatrix2[0][1];
    //     assert(s01 == 0);
    // }

    // int[][5] SFDMatrix1;
    // int[][5] SFDMatrix2;

    // function testStorageFixedMatrix() public {
    //     SFDMatrix1[0] = new int[](10);
    //     SFDMatrix2 = SFDMatrix1;

    //     SFDMatrix1[0][0] = 1;
    //     int s200 = SFDMatrix2[0][0];
    //     assert(s200 == 0);

    //     SFDMatrix1[1] = SFDMatrix1[0];

    //     SFDMatrix1[0][1] = 2;
    //     int s111 = SFDMatrix1[1][1];
    //     assert(s111 == 0);
    // }

    // function testMap() public {
    //     // Maps does not work in memory
    //     // mapping (address => uint) memory bal;
    // }

    // function testAllocation() public {
    //     Person memory aliceM;
    //     aliceM.friends[1] = "Bob";
    //     // assert(aliceM.friends[0] == "");
    //     // assert(aliceM.friends[1] == "Bob");
    // }

    // function testAssignment() public {
    //     Storage s = new Storage();
    //     assert(s.useAssign() == 1);
    // }

    // function testExternalAssignment() public {
    //     ExternalContract c = new ExternalContract();
    //     (int v1, int v2) = c.getResult();
    //     assert(v1 == 2);
    //     assert(v2 == 0);
    // }

    // function testExternalAssignment2() public {
    //     ExternalContract c = new ExternalContract();
    //     (int v1, int v2) = c.getResult2();
    //     assert(v1 == 2);
    //     assert(v2 == 1);
    // }

    // function testExternalAssignment3() public {
    //     ExternalContract c = new ExternalContract();
    //     (int v1, int v2) = c.getResult3();
    //     assert(v1 == 0);
    //     assert(v2 == 0);
    // }

    // function testDifferentAssignment() public {
    //     Storage s = new Storage();
    //     assert(s.useDifferentAssign() == 1);
    // }
}
