// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
import "remix_tests.sol"; // this import is automatically injected by Remix.
import "hardhat/console.sol";
import "../contracts/storage.sol";

contract BallotTest {
    struct Person {
        int age;
        bool isMale;
        string[10] friends;
    }

    Person alice;
    Person ana;
    Person carolina;
    Person[] family;

    int[] vInt1;
    int[] vInt2;

    mapping (address => uint) public balances;

    function testStorage() public {
        int aliceAgeBefore = alice.age;
        Assert.equal(aliceAgeBefore, 0, "Alice age should be the default value");
        family.push(alice);
        alice.age = 20;
        int aliceAge = family[0].age;
        Assert.equal(aliceAge, 0, "alice age should not change change");

        Person memory bob;
        bob.age = 40;
        family.push(bob);
        bob.age = 41;
        int bobAge = family[1].age;
        Assert.equal(bobAge, 40, "bobAge should be remain the same");
    }

    function testCanCopyStorage() public {
        carolina.age = 20;
        ana = carolina;
        Assert.equal(ana.age, 20, "Should be the same age");
    }

    function testCanCompare() public {
        // bool aliceEqAna = alice == ana;
        // Can not compare structure in storage

        // bool sameArray = vInt1 == vInt2;
        // Can not compare arrays in storage

        Person memory pMemory1;
        Person memory pMemory2;

        // bool sameMemory = pMemory1 == pMemory2;
        // Can not compare structures in memory

        int[] memory v1;
        int[] memory v2;

        // bool v1EqV2 = v1 == v2;
        // Can not compare arrays in memory
    }

    function testArray() public {
        Person[] memory friends = new Person[](10);
        friends[1] = friends[0];
        friends[0].age = 20;

        int friendAge1 = friends[1].age;
        Assert.equal(friendAge1, 20, "friendAge1 should be a shallow copied");
    }

    function testShallowStruct() public {
        Person memory eve;
        Person memory carol;

        carol = eve;
        eve.age = 20;

        int v1 = carol.age;
        Assert.equal(v1, 20, "Carol should be shallower copied");
    }

    int[] public ages;

    function testUsingArrayStorage() public {
        ages.push(0);
        ages.push(1);

        uint agesLength = ages.length;
        Assert.equal(agesLength, 2, "Should added two values");
        int arrayValue = ages[1];
        Assert.equal(arrayValue, 1, "Should allow to write");
    }

    function testDynamicVec() public {
        int[] memory yearsVec;
        int[] memory numbers;

        numbers = yearsVec;
        yearsVec = new int[](10);

        uint numbersSize = numbers.length;
        Assert.equal(numbersSize, 0, "did not copy yearsVec");

        numbers = yearsVec;
        numbersSize = numbers.length;
        Assert.equal(numbersSize, 10, "copied yearsVec");

        yearsVec[0] = 1;
        int numbers0 = numbers[0];
        Assert.equal(numbers0, 1, "shallow embedding");
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

        int v200 = matrix2[0][0];

        Assert.equal(v200, 1, "Should shallow copy");
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

    function testMap() public {
        // Maps does not work in memory
        // mapping (address => uint) memory bal;
    }

    function testAllocation() public {
        Person memory aliceM;
        aliceM.friends[1] = "Bob";
        Assert.equal(aliceM.friends[0], "", "Default string");
        Assert.equal(aliceM.friends[1], "Bob", "Assigment");
    }

    function testAssignment() public {
        Storage s = new Storage();
        Assert.equal(s.useAssign(), 1, "Same assignment");
    }

    function testExternalAssignment() public {
        ExternalContract c = new ExternalContract();
        Assert.equal(c.getResult(), 0, "Not the same assignment");
    }

    function testDifferentAssignment() public {
        Storage s = new Storage();
        Assert.equal(s.useDifferentAssign(), 1, "Same assignment");
    }
}